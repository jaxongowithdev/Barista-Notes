import 'package:flutter/material.dart';
import '../database/storage_manager.dart';
import '../models/glossary_term.dart';
import '../utils/visual_themes.dart';

class GlossaryView extends StatefulWidget {
  const GlossaryView({super.key});

  @override
  State<GlossaryView> createState() => _GlossaryViewState();
}

class _GlossaryViewState extends State<GlossaryView> {
  final _storage = StorageManager.instance;
  final _searchController = TextEditingController();
  List<GlossaryTerm> _allTerms = [];
  List<GlossaryTerm> _filteredTerms = [];
  bool _isLoading = true;
  String? _selectedCategory;

  final List<String> _categories = [
    'All',
    'Brewing',
    'Beans',
    'Equipment',
    'Tasting',
    'Processing',
    'Techniques',
  ];

  @override
  void initState() {
    super.initState();
    _loadTerms();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadTerms() async {
    try {
      final terms = await _storage.getAllGlossaryTerms();
      setState(() {
        _allTerms = terms;
        _filteredTerms = terms;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading glossary terms: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterTerms() {
    setState(() {
      _filteredTerms = _allTerms.where((term) {
        // Filter by category
        if (_selectedCategory != null && _selectedCategory != 'All') {
          if (term.category != _selectedCategory) return false;
        }

        // Filter by search query
        if (_searchController.text.isNotEmpty) {
          final query = _searchController.text.toLowerCase();
          return term.term.toLowerCase().contains(query) ||
              term.definition.toLowerCase().contains(query);
        }

        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Glossary'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              key: const ValueKey('glossary_search_field'),
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search terms...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _filterTerms();
                        },
                      )
                    : null,
              ),
              onChanged: (value) => _filterTerms(),
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Category filters
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: _categories.map((category) {
                      final isSelected = _selectedCategory == category ||
                          (_selectedCategory == null && category == 'All');
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          key: ValueKey('category_$category'),
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedCategory =
                                  category == 'All' ? null : category;
                              _filterTerms();
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                // Results count
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Text(
                        '${_filteredTerms.length} terms',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Spacer(),
                      if (_searchController.text.isNotEmpty ||
                          _selectedCategory != null)
                        TextButton.icon(
                          key: const ValueKey('clear_filters_button'),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _selectedCategory = null;
                              _filterTerms();
                            });
                          },
                          icon: const Icon(Icons.clear),
                          label: const Text('Clear'),
                        ),
                    ],
                  ),
                ),
                // Terms list
                Expanded(
                  child: _filteredTerms.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No terms found',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _filteredTerms.length,
                          itemBuilder: (context, index) {
                            return _buildTermCard(_filteredTerms[index]);
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildTermCard(GlossaryTerm term) {
    return Card(
      key: ValueKey('term_${term.id}'),
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showTermDetails(term),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      term.term,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: VisualThemes.mediumRoast,
                          ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(term.category).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      term.category,
                      style: TextStyle(
                        fontSize: 12,
                        color: _getCategoryColor(term.category),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                term.definition,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              if (term.example.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        term.example,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'brewing':
        return VisualThemes.manualBlue;
      case 'beans':
        return VisualThemes.mediumRoast;
      case 'equipment':
        return VisualThemes.pressureRed;
      case 'tasting':
        return VisualThemes.immersionPurple;
      case 'processing':
        return Colors.orange;
      case 'techniques':
        return Colors.green;
      default:
        return VisualThemes.mediumRoast;
    }
  }

  void _showTermDetails(GlossaryTerm term) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Drag handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Term title
                  Text(
                    term.term,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: VisualThemes.mediumRoast,
                        ),
                  ),
                  const SizedBox(height: 8),
                  // Category chip
                  Chip(
                    label: Text(term.category),
                    backgroundColor: _getCategoryColor(term.category).withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: _getCategoryColor(term.category),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Definition
                  Text(
                    'Definition',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    term.definition,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  // Example
                  if (term.example.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Example',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.blue.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.lightbulb_outline,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              term.example,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  // Related terms
                  if (term.relatedTermsList.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Related Terms',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: term.relatedTermsList
                          .map((relatedTerm) => Chip(
                                label: Text(relatedTerm),
                                backgroundColor: Colors.grey[200],
                              ))
                          .toList(),
                    ),
                  ],
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

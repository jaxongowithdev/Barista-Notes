import 'package:flutter/material.dart';
import '../database/storage_manager.dart';
import '../models/brew_method.dart';
import '../models/coffee_bean.dart';
import '../models/glossary_term.dart';
import '../utils/visual_themes.dart';
import 'method_details_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _storage = StorageManager.instance;
  final _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isSearching = false;
  String _searchType = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      List<dynamic> results = [];

      if (_searchType == 'All' || _searchType == 'Methods') {
        final methods = await _storage.searchBrewMethods(query);
        results.addAll(methods);
      }

      if (_searchType == 'All' || _searchType == 'Beans') {
        final beans = await _storage.searchCoffeeBeans(query);
        results.addAll(beans);
      }

      if (_searchType == 'All' || _searchType == 'Glossary') {
        final terms = await _storage.searchGlossaryTerms(query);
        results.addAll(terms);
      }

      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (e) {
      debugPrint('Error searching: $e');
      setState(() {
        _isSearching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              key: const ValueKey('search_field'),
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search methods, beans, terms...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _performSearch('');
                        },
                      )
                    : null,
              ),
              onChanged: _performSearch,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Filter Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: ['All', 'Methods', 'Beans', 'Glossary'].map((type) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(type),
                    selected: _searchType == type,
                    onSelected: (selected) {
                      setState(() {
                        _searchType = type;
                      });
                      _performSearch(_searchController.text);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          // Results
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchController.text.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Search for brewing methods, beans, or terms',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    if (_isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final item = _searchResults[index];
        if (item is BrewMethod) {
          return _buildMethodCard(item);
        } else if (item is CoffeeBean) {
          return _buildBeanCard(item);
        } else if (item is GlossaryTerm) {
          return _buildGlossaryCard(item);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildMethodCard(BrewMethod method) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                VisualThemes.getCategoryColor(method.category),
                VisualThemes.getCategoryColor(method.category).withOpacity(0.6),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.coffee_maker, color: Colors.white),
        ),
        title: Text(method.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${method.origin} • ${method.brewTime}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MethodDetailsView(method: method),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBeanCard(CoffeeBean bean) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: VisualThemes.mediumRoast.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.coffee, color: Colors.brown),
        ),
        title: Text(bean.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${bean.origin} • ${bean.type}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          _showBeanDetails(bean);
        },
      ),
    );
  }

  Widget _buildGlossaryCard(GlossaryTerm term) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: VisualThemes.latte.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.book, color: Colors.brown),
        ),
        title: Text(term.term, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          term.definition,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          _showTermDetails(term);
        },
      ),
    );
  }

  void _showBeanDetails(CoffeeBean bean) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bean.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Chip(label: Text(bean.type)),
                    const SizedBox(width: 8),
                    Chip(label: Text(bean.roastLevel)),
                  ],
                ),
                const SizedBox(height: 16),
                Text('Origin: ${bean.origin}'),
                const SizedBox(height: 16),
                const Text('Description:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(bean.description),
                const SizedBox(height: 16),
                const Text('Flavor Notes:', style: TextStyle(fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 8,
                  children: bean.flavorNotesList.map((note) => Chip(label: Text(note))).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showTermDetails(GlossaryTerm term) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(term.term),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Chip(label: Text(term.category)),
              const SizedBox(height: 12),
              Text(term.definition),
              if (term.example.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text('Example:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(term.example, style: const TextStyle(fontStyle: FontStyle.italic)),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

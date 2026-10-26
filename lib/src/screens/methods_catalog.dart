import 'package:flutter/material.dart';
import '../database/storage_manager.dart';
import '../models/brew_method.dart';
import '../utils/visual_themes.dart';
import 'method_details_view.dart';

class MethodsCatalog extends StatefulWidget {
  const MethodsCatalog({super.key});

  @override
  State<MethodsCatalog> createState() => _MethodsCatalogState();
}

class _MethodsCatalogState extends State<MethodsCatalog> {
  final _storage = StorageManager.instance;
  List<BrewMethod> _allMethods = [];
  List<BrewMethod> _filteredMethods = [];
  bool _isLoading = true;
  bool _isGridView = true;
  String? _selectedCategory;
  String? _selectedDifficulty;

  @override
  void initState() {
    super.initState();
    _loadMethods();
  }

  Future<void> _loadMethods() async {
    try {
      final methods = await _storage.getAllBrewMethods();
      setState(() {
        _allMethods = methods;
        _filteredMethods = methods;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading methods: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _applyFilters() {
    setState(() {
      _filteredMethods = _allMethods.where((method) {
        if (_selectedCategory != null && method.category != _selectedCategory) {
          return false;
        }
        if (_selectedDifficulty != null && method.difficulty != _selectedDifficulty) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brewing Methods'),
        actions: [
          IconButton(
            key: const ValueKey('toggle_view_button'),
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          IconButton(
            key: const ValueKey('filter_button'),
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (_selectedCategory != null || _selectedDifficulty != null)
                  _buildFilterChips(),
                Expanded(
                  child: _isGridView ? _buildGridView() : _buildListView(),
                ),
              ],
            ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 8,
        children: [
          if (_selectedCategory != null)
            Chip(
              label: Text(_selectedCategory!),
              onDeleted: () {
                setState(() {
                  _selectedCategory = null;
                  _applyFilters();
                });
              },
            ),
          if (_selectedDifficulty != null)
            Chip(
              label: Text(_selectedDifficulty!),
              onDeleted: () {
                setState(() {
                  _selectedDifficulty = null;
                  _applyFilters();
                });
              },
            ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _filteredMethods.length,
      itemBuilder: (context, index) {
        return _buildMethodGridCard(_filteredMethods[index]);
      },
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredMethods.length,
      itemBuilder: (context, index) {
        return _buildMethodListCard(_filteredMethods[index]);
      },
    );
  }

  Widget _buildMethodGridCard(BrewMethod method) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        key: ValueKey('method_${method.id}'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MethodDetailsView(method: method),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      VisualThemes.getCategoryColor(method.category),
                      VisualThemes.getCategoryColor(method.category).withOpacity(0.6),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.coffee_maker,
                    size: 50,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    method.origin,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: VisualThemes.getDifficultyColor(method.difficulty).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            method.difficulty,
                            style: TextStyle(
                              fontSize: 10,
                              color: VisualThemes.getDifficultyColor(method.difficulty),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.timer, size: 12),
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          method.brewTime,
                          style: const TextStyle(fontSize: 10),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodListCard(BrewMethod method) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        key: ValueKey('method_${method.id}'),
        leading: Container(
          width: 60,
          height: 60,
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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(method.origin),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: VisualThemes.getDifficultyColor(method.difficulty).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    method.difficulty,
                    style: TextStyle(
                      fontSize: 10,
                      color: VisualThemes.getDifficultyColor(method.difficulty),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.timer, size: 12),
                const SizedBox(width: 2),
                Flexible(
                  child: Text(
                    method.brewTime,
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
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

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Methods'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: ['Manual', 'Pressure', 'Immersion'].map((category) {
                return ChoiceChip(
                  label: Text(category),
                  selected: _selectedCategory == category,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = selected ? category : null;
                    });
                    Navigator.pop(context);
                    _applyFilters();
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text('Difficulty', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: ['Beginner', 'Intermediate', 'Advanced'].map((difficulty) {
                return ChoiceChip(
                  label: Text(difficulty),
                  selected: _selectedDifficulty == difficulty,
                  onSelected: (selected) {
                    setState(() {
                      _selectedDifficulty = selected ? difficulty : null;
                    });
                    Navigator.pop(context);
                    _applyFilters();
                  },
                );
              }).toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _selectedCategory = null;
                _selectedDifficulty = null;
              });
              Navigator.pop(context);
              _applyFilters();
            },
            child: const Text('Clear All'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

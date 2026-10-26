import 'package:flutter/material.dart';
import '../models/brew_method.dart';
import '../database/storage_manager.dart';
import '../utils/visual_themes.dart';

class MethodDetailsView extends StatefulWidget {
  final BrewMethod method;

  const MethodDetailsView({
    super.key,
    required this.method,
  });

  @override
  State<MethodDetailsView> createState() => _MethodDetailsViewState();
}

class _MethodDetailsViewState extends State<MethodDetailsView> {
  late BrewMethod _method;
  final _storage = StorageManager.instance;

  @override
  void initState() {
    super.initState();
    _method = widget.method;
  }

  Future<void> _toggleFavorite() async {
    try {
      await _storage.toggleBrewMethodFavorite(_method.id, !_method.isFavorite);
      setState(() {
        _method = _method.copyWith(isFavorite: !_method.isFavorite);
      });
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            actions: [
              IconButton(
                key: const ValueKey('favorite_button'),
                icon: Icon(
                  _method.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: _toggleFavorite,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(_method.name),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      VisualThemes.getCategoryColor(_method.category),
                      VisualThemes.getCategoryColor(_method.category).withOpacity(0.6),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.coffee_maker,
                    size: 80,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Basic Info
                  Row(
                    children: [
                      Chip(
                        label: Text(_method.difficulty),
                        backgroundColor: VisualThemes.getDifficultyColor(_method.difficulty).withOpacity(0.2),
                      ),
                      const SizedBox(width: 8),
                      Chip(
                        label: Text(_method.category),
                        backgroundColor: VisualThemes.getCategoryColor(_method.category).withOpacity(0.2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(Icons.public, 'Origin', _method.origin),
                  _buildInfoRow(Icons.timer, 'Brew Time', _method.brewTime),
                  _buildInfoRow(Icons.local_cafe, 'Serving Size', _method.servingSize),
                  const SizedBox(height: 24),
                  // Description
                  _buildSectionTitle('Description'),
                  Text(_method.description, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 24),
                  // Recipe
                  _buildSectionTitle('Brewing Recipe'),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildRecipeRow('Coffee', _method.coffeeAmount),
                          const Divider(),
                          _buildRecipeRow('Water', _method.waterAmount),
                          const Divider(),
                          _buildRecipeRow('Temperature', _method.temperature),
                          const Divider(),
                          _buildRecipeRow('Grind Size', _method.grindSize),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Equipment
                  _buildSectionTitle('Equipment Needed'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _method.equipmentList.map((eq) => Chip(label: Text(eq))).toList(),
                  ),
                  const SizedBox(height: 24),
                  // Brewing Steps
                  _buildSectionTitle('Brewing Steps'),
                  ..._method.stepsList.asMap().entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: VisualThemes.mediumRoast,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${entry.key + 1}',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Text(entry.value),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 24),
                  // Flavor Profile
                  _buildSectionTitle('Flavor Profile'),
                  _buildFlavorBar('Sweetness', _method.sweetness),
                  _buildFlavorBar('Acidity', _method.acidity),
                  _buildFlavorBar('Bitterness', _method.bitterness),
                  _buildFlavorBar('Body', _method.body),
                  _buildFlavorBar('Aroma', _method.aroma),
                  const SizedBox(height: 24),
                  // Best Beans
                  if (_method.bestBeansList.isNotEmpty) ...[
                    _buildSectionTitle('Best Coffee Beans'),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _method.bestBeansList.map((bean) => Chip(label: Text(bean))).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],
                  // Tips
                  if (_method.tipsList.isNotEmpty) ...[
                    _buildSectionTitle('Tips'),
                    ..._method.tipsList.map((tip) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.lightbulb_outline, size: 20),
                            const SizedBox(width: 8),
                            Expanded(child: Text(tip)),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildRecipeRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildFlavorBar(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text(value.toStringAsFixed(1)),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: value / 5.0,
            backgroundColor: Colors.grey[300],
            minHeight: 8,
          ),
        ],
      ),
    );
  }
}

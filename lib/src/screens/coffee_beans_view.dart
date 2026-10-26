import 'package:flutter/material.dart';
import '../database/storage_manager.dart';
import '../models/coffee_bean.dart';
import '../utils/visual_themes.dart';

class CoffeeBeansView extends StatefulWidget {
  const CoffeeBeansView({super.key});

  @override
  State<CoffeeBeansView> createState() => _CoffeeBeansViewState();
}

class _CoffeeBeansViewState extends State<CoffeeBeansView> {
  final _storage = StorageManager.instance;
  final _searchController = TextEditingController();
  List<CoffeeBean> _allBeans = [];
  List<CoffeeBean> _filteredBeans = [];
  bool _isLoading = true;
  String? _selectedType;
  String? _selectedRoast;

  final List<String> _types = ['All', 'Arabica', 'Robusta'];
  final List<String> _roasts = ['All', 'Light', 'Medium', 'Medium-Dark', 'Dark'];

  @override
  void initState() {
    super.initState();
    _loadBeans();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadBeans() async {
    try {
      final beans = await _storage.getAllCoffeeBeans();
      setState(() {
        _allBeans = beans;
        _filteredBeans = beans;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading coffee beans: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterBeans() {
    setState(() {
      _filteredBeans = _allBeans.where((bean) {
        // Filter by type
        if (_selectedType != null && _selectedType != 'All') {
          if (bean.type != _selectedType) return false;
        }

        // Filter by roast level
        if (_selectedRoast != null && _selectedRoast != 'All') {
          if (bean.roastLevel != _selectedRoast) return false;
        }

        // Filter by search query
        if (_searchController.text.isNotEmpty) {
          final query = _searchController.text.toLowerCase();
          return bean.name.toLowerCase().contains(query) ||
              bean.origin.toLowerCase().contains(query) ||
              bean.flavorNotes.toLowerCase().contains(query);
        }

        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Beans'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              key: const ValueKey('beans_search_field'),
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search beans...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _filterBeans();
                        },
                      )
                    : null,
              ),
              onChanged: (value) => _filterBeans(),
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Type filters
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: _types.map((type) {
                      final isSelected = _selectedType == type ||
                          (_selectedType == null && type == 'All');
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          key: ValueKey('type_$type'),
                          label: Text(type),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedType = type == 'All' ? null : type;
                              _filterBeans();
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                // Roast level filters
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: _roasts.map((roast) {
                      final isSelected = _selectedRoast == roast ||
                          (_selectedRoast == null && roast == 'All');
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          key: ValueKey('roast_$roast'),
                          label: Text(roast),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedRoast = roast == 'All' ? null : roast;
                              _filterBeans();
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
                        '${_filteredBeans.length} beans',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Spacer(),
                      if (_searchController.text.isNotEmpty ||
                          _selectedType != null ||
                          _selectedRoast != null)
                        TextButton.icon(
                          key: const ValueKey('clear_filters_button'),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _selectedType = null;
                              _selectedRoast = null;
                              _filterBeans();
                            });
                          },
                          icon: const Icon(Icons.clear),
                          label: const Text('Clear'),
                        ),
                    ],
                  ),
                ),
                // Beans list
                Expanded(
                  child: _filteredBeans.isEmpty
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
                                'No beans found',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _filteredBeans.length,
                          itemBuilder: (context, index) {
                            return _buildBeanCard(_filteredBeans[index]);
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildBeanCard(CoffeeBean bean) {
    return Card(
      key: ValueKey('bean_${bean.id}'),
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showBeanDetails(bean),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bean.name,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: VisualThemes.mediumRoast,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.public, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              bean.origin,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getTypeColor(bean.type).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      bean.type,
                      style: TextStyle(
                        fontSize: 12,
                        color: _getTypeColor(bean.type),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  _buildInfoChip(
                    Icons.brightness_6,
                    bean.roastLevel,
                    _getRoastColor(bean.roastLevel),
                  ),
                  _buildInfoChip(
                    Icons.terrain,
                    bean.altitude,
                    Colors.green,
                  ),
                  _buildInfoChip(
                    Icons.science,
                    bean.processing,
                    Colors.blue,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                bean.flavorNotes,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: color),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'arabica':
        return VisualThemes.manualBlue;
      case 'robusta':
        return VisualThemes.pressureRed;
      default:
        return VisualThemes.mediumRoast;
    }
  }

  Color _getRoastColor(String roast) {
    switch (roast.toLowerCase()) {
      case 'light':
        return VisualThemes.latte;
      case 'medium':
        return VisualThemes.mediumRoast;
      case 'medium-dark':
        return VisualThemes.darkRoast;
      case 'dark':
        return VisualThemes.espresso;
      default:
        return VisualThemes.mediumRoast;
    }
  }

  void _showBeanDetails(CoffeeBean bean) {
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
                  // Bean name
                  Text(
                    bean.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: VisualThemes.mediumRoast,
                        ),
                  ),
                  const SizedBox(height: 8),
                  // Origin and type
                  Row(
                    children: [
                      Chip(
                        avatar: const Icon(Icons.public, size: 16),
                        label: Text(bean.origin),
                        backgroundColor: Colors.blue.withOpacity(0.1),
                      ),
                      const SizedBox(width: 8),
                      Chip(
                        label: Text(bean.type),
                        backgroundColor: _getTypeColor(bean.type).withOpacity(0.2),
                        labelStyle: TextStyle(
                          color: _getTypeColor(bean.type),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Details
                  _buildDetailRow('Roast Level', bean.roastLevel, Icons.brightness_6),
                  _buildDetailRow('Altitude', bean.altitude, Icons.terrain),
                  _buildDetailRow('Processing', bean.processing, Icons.science),
                  const SizedBox(height: 16),
                  // Flavor profile
                  Text(
                    'Flavor Profile',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    bean.flavorNotes,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  // Characteristics
                  Text(
                    'Characteristics',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  _buildCharacteristicBar('Acidity', bean.acidity, VisualThemes.manualBlue),
                  const SizedBox(height: 8),
                  _buildCharacteristicBar('Body', bean.body, VisualThemes.pressureRed),
                  const SizedBox(height: 8),
                  _buildCharacteristicBar('Sweetness', bean.sweetness, VisualThemes.immersionPurple),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: VisualThemes.mediumRoast),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildCharacteristicBar(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text('${value.toStringAsFixed(1)}/5.0'),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value / 5.0,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}

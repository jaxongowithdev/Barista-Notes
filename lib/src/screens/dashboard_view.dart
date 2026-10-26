import 'package:flutter/material.dart';
import '../database/storage_manager.dart';
import '../models/brew_method.dart';
import '../models/learning_progress.dart';
import '../utils/visual_themes.dart';
import 'method_details_view.dart';
import 'glossary_view.dart';
import 'coffee_beans_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final _storage = StorageManager.instance;
  bool _isLoading = true;
  BrewMethod? _methodOfTheDay;
  List<BrewMethod> _popularMethods = [];
  LearningProgress? _progress;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final method = await _storage.getRandomBrewMethod();
      final methods = await _storage.getAllBrewMethods();
      final progress = await _storage.getLearningProgress();

      setState(() {
        _methodOfTheDay = method;
        _popularMethods = methods.take(8).toList();
        _progress = progress;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading dashboard data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Barista Notes'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: VisualThemes.coffeeGradient,
                ),
              ),
            ),
          ),
          if (_isLoading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 16),
                // Progress Card
                if (_progress != null)
                  _buildProgressCard(),
                const SizedBox(height: 16),
                // Method of the Day
                _buildSectionHeader('Brew of the Day'),
                if (_methodOfTheDay != null) _buildMethodOfTheDay(),
                const SizedBox(height: 24),
                // Quick Access
                _buildSectionHeader('Quick Access'),
                _buildQuickAccessButtons(),
                const SizedBox(height: 24),
                // Popular Methods
                _buildSectionHeader('Popular Methods'),
                _buildPopularMethods(),
                const SizedBox(height: 24),
              ]),
            ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Learning Progress',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildStatItem(
                      Icons.coffee,
                      '${_progress!.methodsLearned}',
                      'Methods',
                    ),
                  ),
                  Expanded(
                    child: _buildStatItem(
                      Icons.quiz,
                      '${_progress!.quizzesCompleted}',
                      'Quizzes',
                    ),
                  ),
                  Expanded(
                    child: _buildStatItem(
                      Icons.percent,
                      '${_progress!.accuracy.toStringAsFixed(0)}%',
                      'Accuracy',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: VisualThemes.mediumRoast),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildMethodOfTheDay() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          key: ValueKey('method_${_methodOfTheDay!.id}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MethodDetailsView(method: _methodOfTheDay!),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: VisualThemes.coffeeGradient,
                ),
                child: Center(
                  child: Icon(
                    Icons.coffee_maker,
                    size: 80,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _methodOfTheDay!.name,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Chip(
                          label: Text(_methodOfTheDay!.difficulty),
                          backgroundColor: VisualThemes.getDifficultyColor(
                            _methodOfTheDay!.difficulty,
                          ).withOpacity(0.2),
                        ),
                        const SizedBox(width: 8),
                        Chip(
                          label: Text(_methodOfTheDay!.category),
                          backgroundColor: VisualThemes.getCategoryColor(
                            _methodOfTheDay!.category,
                          ).withOpacity(0.2),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _methodOfTheDay!.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.timer_outlined, size: 16),
                        const SizedBox(width: 4),
                        Text(_methodOfTheDay!.brewTime),
                        const SizedBox(width: 16),
                        const Icon(Icons.public, size: 16),
                        const SizedBox(width: 4),
                        Text(_methodOfTheDay!.origin),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularMethods() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _popularMethods.length,
        itemBuilder: (context, index) {
          final method = _popularMethods[index];
          return _buildMethodCard(method);
        },
      ),
    );
  }

  Widget _buildMethodCard(BrewMethod method) {
    return SizedBox(
      width: 160,
      child: Card(
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
              Container(
                height: 100,
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
                    size: 40,
                    color: Colors.white.withOpacity(0.8),
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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAccessButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: _buildQuickAccessCard(
              icon: Icons.book_outlined,
              label: 'Glossary',
              subtitle: '50 Terms',
              color: VisualThemes.latte,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GlossaryView(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildQuickAccessCard(
              icon: Icons.coffee_outlined,
              label: 'Coffee Beans',
              subtitle: '81 Beans',
              color: VisualThemes.mediumRoast,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CoffeeBeansView(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessCard({
    required IconData icon,
    required String label,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        key: ValueKey('quick_access_$label'),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.2),
                color.withOpacity(0.1),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 32,
                color: color,
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

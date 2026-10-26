import 'package:flutter/material.dart';
import '../database/storage_manager.dart';
import '../utils/visual_themes.dart';

class IntroScreen extends StatelessWidget {
  final VoidCallback onDismiss;

  const IntroScreen({
    super.key,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: VisualThemes.coffeeGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                const Icon(
                  Icons.coffee,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 24),
                Text(
                  'Barista Notes',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Learn • Brew • Explore',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white70,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                _buildFeatureItem(
                  context,
                  Icons.category_outlined,
                  '40+ Brewing Methods',
                  'Master techniques from around the world',
                ),
                const SizedBox(height: 16),
                _buildFeatureItem(
                  context,
                  Icons.coffee_maker_outlined,
                  '80+ Coffee Beans',
                  'Explore origins, flavors, and processing',
                ),
                const SizedBox(height: 16),
                _buildFeatureItem(
                  context,
                  Icons.book_outlined,
                  '150+ Glossary Terms',
                  'Learn the language of coffee',
                ),
                const SizedBox(height: 16),
                _buildFeatureItem(
                  context,
                  Icons.quiz_outlined,
                  '800+ Quiz Questions',
                  'Test your coffee knowledge',
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.offline_pin_outlined,
                        color: Colors.white,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Works 100% Offline',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'No internet required • No tracking • Your data stays on your device',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white70,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  key: const ValueKey('get_started_button'),
                  onPressed: () async {
                    await _dismissIntro(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: VisualThemes.espresso,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _dismissIntro(BuildContext context) async {
    try {
      final storage = StorageManager.instance;
      final currentPrefs = await storage.getUserPreferences();
      final updatedPrefs = currentPrefs.copyWith(showIntro: false);
      await storage.updateUserPreferences(updatedPrefs);
      onDismiss();
    } catch (e) {
      debugPrint('Error dismissing intro: $e');
      onDismiss();
    }
  }
}

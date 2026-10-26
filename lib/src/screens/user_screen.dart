import 'package:flutter/material.dart';
import '../database/storage_manager.dart';
import 'navigation_shell.dart';
import 'intro_screen.dart';
import '../utils/visual_themes.dart';
import '../models/user_preferences.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _storage = StorageManager.instance;
  bool _isInitialized = false;
  UserPreferences? _preferences;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Seed database with initial data
      await _storage.seedDatabase();

      // Load preferences
      final prefs = await _storage.getUserPreferences();

      setState(() {
        _preferences = prefs;
        _isInitialized = true;
      });
    } catch (e) {
      debugPrint('Error initializing app: $e');
      setState(() {
        _preferences = UserPreferences(); // Use default preferences
        _isInitialized = true;
      });
    }
  }

  Future<void> _reloadPreferences() async {
    try {
      final prefs = await _storage.getUserPreferences();
      setState(() {
        _preferences = prefs;
      });
    } catch (e) {
      debugPrint('Error reloading preferences: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized || _preferences == null) {
      return MaterialApp(
        home: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: VisualThemes.coffeeGradient,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Brewing Coffee Guide...',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Learn • Brew • Explore',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Determine theme based on preferences
    ThemeMode themeMode;
    switch (_preferences!.theme) {
      case 'light':
        themeMode = ThemeMode.light;
        break;
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
      case 'system':
      default:
        themeMode = ThemeMode.system;
        break;
    }

    // Determine initial screen
    final Widget initialScreen = _preferences!.showIntro
        ? IntroScreen(onDismiss: _reloadPreferences)
        : NavigationShell(onPreferencesChanged: _reloadPreferences);

    return MaterialApp(
      key: ValueKey(_preferences!.theme), // Force rebuild when theme changes
      title: 'Barista Notes',
      debugShowCheckedModeBanner: false,
      theme: VisualThemes.lightTheme,
      darkTheme: VisualThemes.darkTheme,
      themeMode: themeMode,
      themeAnimationDuration: const Duration(milliseconds: 300),
      themeAnimationCurve: Curves.easeInOut,
      home: initialScreen,
    );
  }
}

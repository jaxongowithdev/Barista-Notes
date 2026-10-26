import 'package:flutter/material.dart';
import 'dashboard_view.dart';
import 'methods_catalog.dart';
import 'search_view.dart';
import 'quiz_view.dart';
import 'config_view.dart';

class NavigationShell extends StatefulWidget {
  final VoidCallback onPreferencesChanged;

  const NavigationShell({
    super.key,
    required this.onPreferencesChanged,
  });

  @override
  State<NavigationShell> createState() => _NavigationShellState();
}

class _NavigationShellState extends State<NavigationShell> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const DashboardView(),
      const MethodsCatalog(),
      const SearchView(),
      const QuizView(),
      ConfigView(onPreferencesChanged: widget.onPreferencesChanged),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            key: ValueKey('nav_home'),
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            key: ValueKey('nav_methods'),
            icon: Icon(Icons.coffee_outlined),
            selectedIcon: Icon(Icons.coffee),
            label: 'Methods',
          ),
          NavigationDestination(
            key: ValueKey('nav_search'),
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            key: ValueKey('nav_quiz'),
            icon: Icon(Icons.quiz_outlined),
            selectedIcon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
          NavigationDestination(
            key: ValueKey('nav_settings'),
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

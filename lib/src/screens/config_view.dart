import 'package:flutter/material.dart';
import '../database/storage_manager.dart';
import '../models/user_preferences.dart';
import '../models/learning_progress.dart';
import '../utils/visual_themes.dart';

class ConfigView extends StatefulWidget {
  final VoidCallback onPreferencesChanged;

  const ConfigView({
    super.key,
    required this.onPreferencesChanged,
  });

  @override
  State<ConfigView> createState() => _ConfigViewState();
}

class _ConfigViewState extends State<ConfigView> {
  final _storage = StorageManager.instance;
  UserPreferences? _preferences;
  LearningProgress? _progress;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final prefs = await _storage.getUserPreferences();
      final progress = await _storage.getLearningProgress();

      setState(() {
        _preferences = prefs;
        _progress = progress;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading settings: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updatePreference(UserPreferences newPrefs) async {
    try {
      await _storage.updateUserPreferences(newPrefs);
      setState(() {
        _preferences = newPrefs;
      });
      widget.onPreferencesChanged();
    } catch (e) {
      debugPrint('Error updating preference: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                // Progress Summary
                if (_progress != null) _buildProgressSection(),
                const Divider(),
                // Appearance
                _buildSectionHeader('Appearance'),
                _buildThemeSelector(),
                const Divider(),
                // Units
                _buildSectionHeader('Units'),
                _buildTemperatureUnitSelector(),
                _buildVolumeUnitSelector(),
                const Divider(),
                // App Info
                _buildSectionHeader('About'),
                _buildInfoTiles(),
                const Divider(),
                // Data Management
                _buildSectionHeader('Data Management'),
                _buildResetButton(),
                const SizedBox(height: 32),
              ],
            ),
    );
  }

  Widget _buildProgressSection() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Progress',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildProgressTile(
              Icons.coffee,
              'Methods Learned',
              '${_progress!.methodsLearned}',
            ),
            _buildProgressTile(
              Icons.quiz,
              'Quizzes Completed',
              '${_progress!.quizzesCompleted}',
            ),
            _buildProgressTile(
              Icons.check_circle,
              'Correct Answers',
              '${_progress!.correctAnswers}',
            ),
            _buildProgressTile(
              Icons.percent,
              'Accuracy',
              '${_progress!.accuracy.toStringAsFixed(1)}%',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: VisualThemes.mediumRoast),
          const SizedBox(width: 16),
          Expanded(child: Text(label)),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: VisualThemes.mediumRoast,
            ),
      ),
    );
  }

  Widget _buildThemeSelector() {
    return Column(
      children: [
        RadioListTile<String>(
          key: const ValueKey('theme_light'),
          title: const Text('Light Mode'),
          value: 'light',
          groupValue: _preferences!.theme,
          onChanged: (value) {
            _updatePreference(_preferences!.copyWith(theme: value));
          },
        ),
        RadioListTile<String>(
          key: const ValueKey('theme_dark'),
          title: const Text('Dark Mode'),
          value: 'dark',
          groupValue: _preferences!.theme,
          onChanged: (value) {
            _updatePreference(_preferences!.copyWith(theme: value));
          },
        ),
        RadioListTile<String>(
          key: const ValueKey('theme_system'),
          title: const Text('System Default'),
          value: 'system',
          groupValue: _preferences!.theme,
          onChanged: (value) {
            _updatePreference(_preferences!.copyWith(theme: value));
          },
        ),
      ],
    );
  }

  Widget _buildTemperatureUnitSelector() {
    return SwitchListTile(
      key: const ValueKey('temperature_unit_toggle'),
      title: const Text('Temperature Unit'),
      subtitle: Text(_preferences!.temperatureUnit == 'celsius' ? 'Celsius (°C)' : 'Fahrenheit (°F)'),
      value: _preferences!.temperatureUnit == 'fahrenheit',
      onChanged: (value) {
        _updatePreference(
          _preferences!.copyWith(
            temperatureUnit: value ? 'fahrenheit' : 'celsius',
          ),
        );
      },
    );
  }

  Widget _buildVolumeUnitSelector() {
    return SwitchListTile(
      key: const ValueKey('volume_unit_toggle'),
      title: const Text('Volume Unit'),
      subtitle: Text(_preferences!.volumeUnit == 'ml' ? 'Milliliters (ml)' : 'Ounces (oz)'),
      value: _preferences!.volumeUnit == 'oz',
      onChanged: (value) {
        _updatePreference(
          _preferences!.copyWith(
            volumeUnit: value ? 'oz' : 'ml',
          ),
        );
      },
    );
  }

  Widget _buildInfoTiles() {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.coffee),
          title: const Text('Barista Notes'),
          subtitle: const Text('Version 1.0.0'),
        ),
        ListTile(
          leading: const Icon(Icons.offline_pin),
          title: const Text('Works 100% Offline'),
          subtitle: const Text('No internet required'),
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip),
          title: const Text('Privacy First'),
          subtitle: const Text('No tracking, no data collection'),
        ),
      ],
    );
  }

  Widget _buildResetButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: OutlinedButton.icon(
        key: const ValueKey('reset_data_button'),
        onPressed: _showResetConfirmation,
        icon: const Icon(Icons.restore),
        label: const Text('Reset All Data'),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  void _showResetConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset All Data?'),
        content: const Text(
          'This will delete all your progress, favorites, and quiz results. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _resetAllData();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  Future<void> _resetAllData() async {
    try {
      await _storage.resetAllData();
      await _loadData();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('All data has been reset'),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error resetting data: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error resetting data'),
          ),
        );
      }
    }
  }
}

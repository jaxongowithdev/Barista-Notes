class UserPreferences {
  final String theme; // 'light', 'dark', 'system'
  final bool showIntro; // Show introduction on first launch
  final String temperatureUnit; // 'celsius', 'fahrenheit'
  final String volumeUnit; // 'ml', 'oz'
  final String language; // 'en', 'vi', etc.

  UserPreferences({
    this.theme = 'system',
    this.showIntro = true,
    this.temperatureUnit = 'celsius',
    this.volumeUnit = 'ml',
    this.language = 'en',
  });

  Map<String, dynamic> toMap() {
    return {
      'theme': theme,
      'showIntro': showIntro ? 1 : 0,
      'temperatureUnit': temperatureUnit,
      'volumeUnit': volumeUnit,
      'language': language,
    };
  }

  factory UserPreferences.fromMap(Map<String, dynamic> map) {
    return UserPreferences(
      theme: map['theme'] as String? ?? 'system',
      showIntro: (map['showIntro'] as int?) == 1 || map['showIntro'] == null,
      temperatureUnit: map['temperatureUnit'] as String? ?? 'celsius',
      volumeUnit: map['volumeUnit'] as String? ?? 'ml',
      language: map['language'] as String? ?? 'en',
    );
  }

  UserPreferences copyWith({
    String? theme,
    bool? showIntro,
    String? temperatureUnit,
    String? volumeUnit,
    String? language,
  }) {
    return UserPreferences(
      theme: theme ?? this.theme,
      showIntro: showIntro ?? this.showIntro,
      temperatureUnit: temperatureUnit ?? this.temperatureUnit,
      volumeUnit: volumeUnit ?? this.volumeUnit,
      language: language ?? this.language,
    );
  }

  String convertTemperature(String temp) {
    if (temperatureUnit == 'fahrenheit') {
      final celsius = int.tryParse(temp.replaceAll(RegExp(r'[^0-9]'), ''));
      if (celsius != null) {
        final fahrenheit = (celsius * 9 / 5) + 32;
        return '${fahrenheit.round()}°F';
      }
    }
    return temp;
  }

  String convertVolume(String vol) {
    if (volumeUnit == 'oz') {
      final ml = int.tryParse(vol.replaceAll(RegExp(r'[^0-9]'), ''));
      if (ml != null) {
        final oz = ml / 29.5735;
        return '${oz.toStringAsFixed(1)}oz';
      }
    }
    return vol;
  }
}

class CoffeeBean {
  final String id;
  final String name;
  final String origin; // Country or region
  final String type; // Arabica, Robusta, Liberica, Excelsa
  final String roastLevel; // Light, Medium, Medium-Dark, Dark
  final String flavorNotes; // Comma separated
  final double sweetness; // 0.0 to 5.0
  final double acidity; // 0.0 to 5.0
  final double body; // 0.0 to 5.0
  final double complexity; // 0.0 to 5.0
  final String processing; // Washed, Natural, Honey, etc.
  final String altitude; // e.g., "1200-1800m"
  final String description;
  final String bestMethods; // Comma separated brewing methods
  final String characteristics;
  final bool isFavorite;
  final DateTime createdAt;

  CoffeeBean({
    required this.id,
    required this.name,
    required this.origin,
    required this.type,
    required this.roastLevel,
    required this.flavorNotes,
    this.sweetness = 3.0,
    this.acidity = 3.0,
    this.body = 3.0,
    this.complexity = 3.0,
    this.processing = '',
    this.altitude = '',
    required this.description,
    this.bestMethods = '',
    this.characteristics = '',
    this.isFavorite = false,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'origin': origin,
      'type': type,
      'roastLevel': roastLevel,
      'flavorNotes': flavorNotes,
      'sweetness': sweetness,
      'acidity': acidity,
      'body': body,
      'complexity': complexity,
      'processing': processing,
      'altitude': altitude,
      'description': description,
      'bestMethods': bestMethods,
      'characteristics': characteristics,
      'isFavorite': isFavorite ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory CoffeeBean.fromMap(Map<String, dynamic> map) {
    return CoffeeBean(
      id: map['id'] as String,
      name: map['name'] as String,
      origin: map['origin'] as String,
      type: map['type'] as String,
      roastLevel: map['roastLevel'] as String,
      flavorNotes: map['flavorNotes'] as String,
      sweetness: (map['sweetness'] as num?)?.toDouble() ?? 3.0,
      acidity: (map['acidity'] as num?)?.toDouble() ?? 3.0,
      body: (map['body'] as num?)?.toDouble() ?? 3.0,
      complexity: (map['complexity'] as num?)?.toDouble() ?? 3.0,
      processing: map['processing'] as String? ?? '',
      altitude: map['altitude'] as String? ?? '',
      description: map['description'] as String,
      bestMethods: map['bestMethods'] as String? ?? '',
      characteristics: map['characteristics'] as String? ?? '',
      isFavorite: (map['isFavorite'] as int?) == 1,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  CoffeeBean copyWith({
    String? id,
    String? name,
    String? origin,
    String? type,
    String? roastLevel,
    String? flavorNotes,
    double? sweetness,
    double? acidity,
    double? body,
    double? complexity,
    String? processing,
    String? altitude,
    String? description,
    String? bestMethods,
    String? characteristics,
    bool? isFavorite,
    DateTime? createdAt,
  }) {
    return CoffeeBean(
      id: id ?? this.id,
      name: name ?? this.name,
      origin: origin ?? this.origin,
      type: type ?? this.type,
      roastLevel: roastLevel ?? this.roastLevel,
      flavorNotes: flavorNotes ?? this.flavorNotes,
      sweetness: sweetness ?? this.sweetness,
      acidity: acidity ?? this.acidity,
      body: body ?? this.body,
      complexity: complexity ?? this.complexity,
      processing: processing ?? this.processing,
      altitude: altitude ?? this.altitude,
      description: description ?? this.description,
      bestMethods: bestMethods ?? this.bestMethods,
      characteristics: characteristics ?? this.characteristics,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  List<String> get flavorNotesList => flavorNotes.isEmpty ? [] : flavorNotes.split(',');
  List<String> get bestMethodsList => bestMethods.isEmpty ? [] : bestMethods.split(',');
}

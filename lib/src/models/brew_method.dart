class BrewMethod {
  final String id;
  final String name;
  final String origin;
  final String difficulty; // Beginner, Intermediate, Advanced
  final String brewTime; // e.g., "3-4 min"
  final String servingSize; // e.g., "1-2 cups"
  final String category; // Manual, Pressure, Immersion
  final String description;
  final String equipment; // Comma separated
  final String coffeeAmount; // e.g., "18g"
  final String waterAmount; // e.g., "300ml"
  final String temperature; // e.g., "92°C"
  final String grindSize; // Fine, Medium-Fine, Medium, Medium-Coarse, Coarse
  final String steps; // Comma separated brewing steps
  final double sweetness; // 0.0 to 5.0
  final double acidity; // 0.0 to 5.0
  final double bitterness; // 0.0 to 5.0
  final double body; // 0.0 to 5.0
  final double aroma; // 0.0 to 5.0
  final String bestBeans; // Comma separated
  final String tips; // Comma separated tips
  final String imagePath;
  final bool isFavorite;
  final DateTime createdAt;

  BrewMethod({
    required this.id,
    required this.name,
    required this.origin,
    required this.difficulty,
    required this.brewTime,
    required this.servingSize,
    required this.category,
    required this.description,
    required this.equipment,
    required this.coffeeAmount,
    required this.waterAmount,
    required this.temperature,
    required this.grindSize,
    required this.steps,
    this.sweetness = 3.0,
    this.acidity = 3.0,
    this.bitterness = 3.0,
    this.body = 3.0,
    this.aroma = 3.0,
    this.bestBeans = '',
    this.tips = '',
    this.imagePath = '',
    this.isFavorite = false,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'origin': origin,
      'difficulty': difficulty,
      'brewTime': brewTime,
      'servingSize': servingSize,
      'category': category,
      'description': description,
      'equipment': equipment,
      'coffeeAmount': coffeeAmount,
      'waterAmount': waterAmount,
      'temperature': temperature,
      'grindSize': grindSize,
      'steps': steps,
      'sweetness': sweetness,
      'acidity': acidity,
      'bitterness': bitterness,
      'body': body,
      'aroma': aroma,
      'bestBeans': bestBeans,
      'tips': tips,
      'imagePath': imagePath,
      'isFavorite': isFavorite ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory BrewMethod.fromMap(Map<String, dynamic> map) {
    return BrewMethod(
      id: map['id'] as String,
      name: map['name'] as String,
      origin: map['origin'] as String,
      difficulty: map['difficulty'] as String,
      brewTime: map['brewTime'] as String,
      servingSize: map['servingSize'] as String,
      category: map['category'] as String,
      description: map['description'] as String,
      equipment: map['equipment'] as String,
      coffeeAmount: map['coffeeAmount'] as String,
      waterAmount: map['waterAmount'] as String,
      temperature: map['temperature'] as String,
      grindSize: map['grindSize'] as String,
      steps: map['steps'] as String,
      sweetness: (map['sweetness'] as num?)?.toDouble() ?? 3.0,
      acidity: (map['acidity'] as num?)?.toDouble() ?? 3.0,
      bitterness: (map['bitterness'] as num?)?.toDouble() ?? 3.0,
      body: (map['body'] as num?)?.toDouble() ?? 3.0,
      aroma: (map['aroma'] as num?)?.toDouble() ?? 3.0,
      bestBeans: map['bestBeans'] as String? ?? '',
      tips: map['tips'] as String? ?? '',
      imagePath: map['imagePath'] as String? ?? '',
      isFavorite: (map['isFavorite'] as int?) == 1,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  BrewMethod copyWith({
    String? id,
    String? name,
    String? origin,
    String? difficulty,
    String? brewTime,
    String? servingSize,
    String? category,
    String? description,
    String? equipment,
    String? coffeeAmount,
    String? waterAmount,
    String? temperature,
    String? grindSize,
    String? steps,
    double? sweetness,
    double? acidity,
    double? bitterness,
    double? body,
    double? aroma,
    String? bestBeans,
    String? tips,
    String? imagePath,
    bool? isFavorite,
    DateTime? createdAt,
  }) {
    return BrewMethod(
      id: id ?? this.id,
      name: name ?? this.name,
      origin: origin ?? this.origin,
      difficulty: difficulty ?? this.difficulty,
      brewTime: brewTime ?? this.brewTime,
      servingSize: servingSize ?? this.servingSize,
      category: category ?? this.category,
      description: description ?? this.description,
      equipment: equipment ?? this.equipment,
      coffeeAmount: coffeeAmount ?? this.coffeeAmount,
      waterAmount: waterAmount ?? this.waterAmount,
      temperature: temperature ?? this.temperature,
      grindSize: grindSize ?? this.grindSize,
      steps: steps ?? this.steps,
      sweetness: sweetness ?? this.sweetness,
      acidity: acidity ?? this.acidity,
      bitterness: bitterness ?? this.bitterness,
      body: body ?? this.body,
      aroma: aroma ?? this.aroma,
      bestBeans: bestBeans ?? this.bestBeans,
      tips: tips ?? this.tips,
      imagePath: imagePath ?? this.imagePath,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  List<String> get equipmentList => equipment.isEmpty ? [] : equipment.split(',');
  List<String> get stepsList => steps.isEmpty ? [] : steps.split('|');
  List<String> get bestBeansList => bestBeans.isEmpty ? [] : bestBeans.split(',');
  List<String> get tipsList => tips.isEmpty ? [] : tips.split('|');
}

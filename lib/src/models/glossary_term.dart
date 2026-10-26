class GlossaryTerm {
  final String id;
  final String term;
  final String definition;
  final String category; // Brewing, Beans, Equipment, Tasting, Processing
  final String example;
  final String relatedTerms; // Comma separated
  final DateTime createdAt;

  GlossaryTerm({
    required this.id,
    required this.term,
    required this.definition,
    required this.category,
    this.example = '',
    this.relatedTerms = '',
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'term': term,
      'definition': definition,
      'category': category,
      'example': example,
      'relatedTerms': relatedTerms,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory GlossaryTerm.fromMap(Map<String, dynamic> map) {
    return GlossaryTerm(
      id: map['id'] as String,
      term: map['term'] as String,
      definition: map['definition'] as String,
      category: map['category'] as String,
      example: map['example'] as String? ?? '',
      relatedTerms: map['relatedTerms'] as String? ?? '',
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  GlossaryTerm copyWith({
    String? id,
    String? term,
    String? definition,
    String? category,
    String? example,
    String? relatedTerms,
    DateTime? createdAt,
  }) {
    return GlossaryTerm(
      id: id ?? this.id,
      term: term ?? this.term,
      definition: definition ?? this.definition,
      category: category ?? this.category,
      example: example ?? this.example,
      relatedTerms: relatedTerms ?? this.relatedTerms,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  List<String> get relatedTermsList => relatedTerms.isEmpty ? [] : relatedTerms.split(',');
}

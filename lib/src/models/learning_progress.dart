class LearningProgress {
  final String id;
  final int methodsLearned;
  final int quizzesCompleted;
  final int correctAnswers;
  final int totalQuizAttempts;
  final int favoriteMethods;
  final int favoriteBeans;
  final List<String> achievements;
  final List<String> completedCategories;
  final DateTime lastActive;
  final DateTime createdAt;

  LearningProgress({
    required this.id,
    this.methodsLearned = 0,
    this.quizzesCompleted = 0,
    this.correctAnswers = 0,
    this.totalQuizAttempts = 0,
    this.favoriteMethods = 0,
    this.favoriteBeans = 0,
    this.achievements = const [],
    this.completedCategories = const [],
    required this.lastActive,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'methodsLearned': methodsLearned,
      'quizzesCompleted': quizzesCompleted,
      'correctAnswers': correctAnswers,
      'totalQuizAttempts': totalQuizAttempts,
      'favoriteMethods': favoriteMethods,
      'favoriteBeans': favoriteBeans,
      'achievements': achievements.join(','),
      'completedCategories': completedCategories.join(','),
      'lastActive': lastActive.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory LearningProgress.fromMap(Map<String, dynamic> map) {
    return LearningProgress(
      id: map['id'] as String,
      methodsLearned: map['methodsLearned'] as int? ?? 0,
      quizzesCompleted: map['quizzesCompleted'] as int? ?? 0,
      correctAnswers: map['correctAnswers'] as int? ?? 0,
      totalQuizAttempts: map['totalQuizAttempts'] as int? ?? 0,
      favoriteMethods: map['favoriteMethods'] as int? ?? 0,
      favoriteBeans: map['favoriteBeans'] as int? ?? 0,
      achievements: (map['achievements'] as String).isEmpty
          ? []
          : (map['achievements'] as String).split(','),
      completedCategories: (map['completedCategories'] as String).isEmpty
          ? []
          : (map['completedCategories'] as String).split(','),
      lastActive: DateTime.parse(map['lastActive'] as String),
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  LearningProgress copyWith({
    String? id,
    int? methodsLearned,
    int? quizzesCompleted,
    int? correctAnswers,
    int? totalQuizAttempts,
    int? favoriteMethods,
    int? favoriteBeans,
    List<String>? achievements,
    List<String>? completedCategories,
    DateTime? lastActive,
    DateTime? createdAt,
  }) {
    return LearningProgress(
      id: id ?? this.id,
      methodsLearned: methodsLearned ?? this.methodsLearned,
      quizzesCompleted: quizzesCompleted ?? this.quizzesCompleted,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      totalQuizAttempts: totalQuizAttempts ?? this.totalQuizAttempts,
      favoriteMethods: favoriteMethods ?? this.favoriteMethods,
      favoriteBeans: favoriteBeans ?? this.favoriteBeans,
      achievements: achievements ?? this.achievements,
      completedCategories: completedCategories ?? this.completedCategories,
      lastActive: lastActive ?? this.lastActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  double get accuracy {
    if (totalQuizAttempts == 0) return 0.0;
    return (correctAnswers / totalQuizAttempts) * 100;
  }
}

class QuizData {
  final String id;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;
  final String category; // Methods, Beans, Equipment, Techniques, Tasting
  final String difficulty; // Easy, Medium, Hard
  final String quizType; // text, image, parameters
  final String imagePath; // For image-based questions
  final DateTime createdAt;

  QuizData({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
    required this.category,
    required this.difficulty,
    this.quizType = 'text',
    this.imagePath = '',
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'options': options.join('|'),
      'correctAnswerIndex': correctAnswerIndex,
      'explanation': explanation,
      'category': category,
      'difficulty': difficulty,
      'quizType': quizType,
      'imagePath': imagePath,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory QuizData.fromMap(Map<String, dynamic> map) {
    return QuizData(
      id: map['id'] as String,
      question: map['question'] as String,
      options: (map['options'] as String).split('|'),
      correctAnswerIndex: map['correctAnswerIndex'] as int,
      explanation: map['explanation'] as String,
      category: map['category'] as String,
      difficulty: map['difficulty'] as String,
      quizType: map['quizType'] as String? ?? 'text',
      imagePath: map['imagePath'] as String? ?? '',
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  QuizData copyWith({
    String? id,
    String? question,
    List<String>? options,
    int? correctAnswerIndex,
    String? explanation,
    String? category,
    String? difficulty,
    String? quizType,
    String? imagePath,
    DateTime? createdAt,
  }) {
    return QuizData(
      id: id ?? this.id,
      question: question ?? this.question,
      options: options ?? this.options,
      correctAnswerIndex: correctAnswerIndex ?? this.correctAnswerIndex,
      explanation: explanation ?? this.explanation,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      quizType: quizType ?? this.quizType,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class QuizResult {
  final String id;
  final String quizId;
  final int selectedAnswerIndex;
  final bool isCorrect;
  final DateTime completedAt;

  QuizResult({
    required this.id,
    required this.quizId,
    required this.selectedAnswerIndex,
    required this.isCorrect,
    required this.completedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quizId': quizId,
      'selectedAnswerIndex': selectedAnswerIndex,
      'isCorrect': isCorrect ? 1 : 0,
      'completedAt': completedAt.toIso8601String(),
    };
  }

  factory QuizResult.fromMap(Map<String, dynamic> map) {
    return QuizResult(
      id: map['id'] as String,
      quizId: map['quizId'] as String,
      selectedAnswerIndex: map['selectedAnswerIndex'] as int,
      isCorrect: (map['isCorrect'] as int) == 1,
      completedAt: DateTime.parse(map['completedAt'] as String),
    );
  }
}

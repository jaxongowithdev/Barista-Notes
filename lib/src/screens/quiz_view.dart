import 'package:flutter/material.dart';
import '../database/storage_manager.dart';
import '../models/quiz_data.dart';
import '../utils/visual_themes.dart';
import 'package:uuid/uuid.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  final _storage = StorageManager.instance;
  List<QuizData> _quizQuestions = [];
  int _currentQuestionIndex = 0;
  int? _selectedAnswer;
  bool _showAnswer = false;
  int _correctAnswers = 0;
  final int _totalQuestions = 10;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuiz();
  }

  Future<void> _loadQuiz() async {
    try {
      final quizzes = await _storage.getRandomQuizzes(_totalQuestions);
      setState(() {
        _quizQuestions = quizzes;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading quiz: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _selectAnswer(int index) {
    if (_showAnswer) return;

    setState(() {
      _selectedAnswer = index;
    });
  }

  Future<void> _submitAnswer() async {
    if (_selectedAnswer == null) return;

    final isCorrect = _selectedAnswer == _quizQuestions[_currentQuestionIndex].correctAnswerIndex;

    setState(() {
      _showAnswer = true;
      if (isCorrect) _correctAnswers++;
    });

    // Save quiz result
    try {
      final result = QuizResult(
        id: const Uuid().v4(),
        quizId: _quizQuestions[_currentQuestionIndex].id,
        selectedAnswerIndex: _selectedAnswer!,
        isCorrect: isCorrect,
        completedAt: DateTime.now(),
      );
      await _storage.insertQuizResult(result);
      await _storage.incrementQuizCompleted(isCorrect);
    } catch (e) {
      debugPrint('Error saving quiz result: $e');
    }
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _quizQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null;
        _showAnswer = false;
      });
    } else {
      _showResults();
    }
  }

  void _showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _correctAnswers >= _totalQuestions * 0.7
                  ? Icons.emoji_events
                  : Icons.local_cafe,
              size: 64,
              color: _correctAnswers >= _totalQuestions * 0.7
                  ? Colors.amber
                  : VisualThemes.mediumRoast,
            ),
            const SizedBox(height: 16),
            Text(
              '$_correctAnswers / $_totalQuestions',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '${((_correctAnswers / _totalQuestions) * 100).toStringAsFixed(0)}% Correct',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Text(
              _correctAnswers >= _totalQuestions * 0.9
                  ? 'Coffee Expert! ☕'
                  : _correctAnswers >= _totalQuestions * 0.7
                      ? 'Great job!'
                      : _correctAnswers >= _totalQuestions * 0.5
                          ? 'Keep learning!'
                          : 'Try again!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetQuiz();
            },
            child: const Text('Take Another Quiz'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _selectedAnswer = null;
      _showAnswer = false;
      _correctAnswers = 0;
      _isLoading = true;
    });
    _loadQuiz();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Quiz'),
        actions: [
          IconButton(
            key: const ValueKey('reset_quiz_button'),
            icon: const Icon(Icons.refresh),
            onPressed: _resetQuiz,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _quizQuestions.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.quiz, size: 64),
                      const SizedBox(height: 16),
                      const Text('No quiz questions available'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _resetQuiz,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    // Progress
                    LinearProgressIndicator(
                      value: (_currentQuestionIndex + 1) / _quizQuestions.length,
                      minHeight: 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Question ${_currentQuestionIndex + 1} of ${_quizQuestions.length}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            'Score: $_correctAnswers/$_currentQuestionIndex',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: VisualThemes.mediumRoast,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Category Chip
                            Chip(
                              label: Text(_quizQuestions[_currentQuestionIndex].category),
                            ),
                            const SizedBox(height: 16),
                            // Question
                            Card(
                              color: VisualThemes.latte.withOpacity(0.2),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  _quizQuestions[_currentQuestionIndex].question,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Options
                            ..._quizQuestions[_currentQuestionIndex].options.asMap().entries.map((entry) {
                              final index = entry.key;
                              final option = entry.value;
                              final isSelected = _selectedAnswer == index;
                              final isCorrect = index == _quizQuestions[_currentQuestionIndex].correctAnswerIndex;

                              Color? cardColor;
                              if (_showAnswer) {
                                if (isCorrect) {
                                  cardColor = Colors.green[100];
                                } else if (isSelected && !isCorrect) {
                                  cardColor = Colors.red[100];
                                }
                              } else if (isSelected) {
                                cardColor = VisualThemes.latte.withOpacity(0.3);
                              }

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Card(
                                  color: cardColor,
                                  child: InkWell(
                                    key: ValueKey('answer_$index'),
                                    onTap: () => _selectAnswer(index),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 32,
                                            height: 32,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: isSelected
                                                    ? VisualThemes.mediumRoast
                                                    : Colors.grey,
                                                width: 2,
                                              ),
                                              color: isSelected
                                                  ? VisualThemes.mediumRoast
                                                  : null,
                                            ),
                                            child: Center(
                                              child: Text(
                                                String.fromCharCode(65 + index),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: isSelected ? Colors.white : Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Text(option),
                                          ),
                                          if (_showAnswer && isCorrect)
                                            const Icon(Icons.check_circle, color: Colors.green),
                                          if (_showAnswer && isSelected && !isCorrect)
                                            const Icon(Icons.cancel, color: Colors.red),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            // Explanation
                            if (_showAnswer) ...[
                              const SizedBox(height: 16),
                              Card(
                                color: Colors.blue[50],
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.lightbulb_outline, color: Colors.blue),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Explanation',
                                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(_quizQuestions[_currentQuestionIndex].explanation),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    // Buttons
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          if (!_showAnswer) ...[
                            Expanded(
                              child: ElevatedButton(
                                key: const ValueKey('submit_answer_button'),
                                onPressed: _selectedAnswer != null ? _submitAnswer : null,
                                child: const Text('Submit Answer'),
                              ),
                            ),
                          ] else ...[
                            Expanded(
                              child: ElevatedButton(
                                key: const ValueKey('next_question_button'),
                                onPressed: _nextQuestion,
                                child: Text(
                                  _currentQuestionIndex < _quizQuestions.length - 1
                                      ? 'Next Question'
                                      : 'See Results',
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/brew_method.dart';
import '../models/coffee_bean.dart';
import '../models/glossary_term.dart';
import '../models/quiz_data.dart';
import '../models/learning_progress.dart';
import '../models/user_preferences.dart';
import 'content_seed.dart';

class StorageManager {
  static final StorageManager instance = StorageManager._init();
  static Database? _database;

  StorageManager._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('coffee_brewing_guide.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // Brew Methods table
    await db.execute('''
      CREATE TABLE brew_methods (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        origin TEXT NOT NULL,
        difficulty TEXT NOT NULL,
        brewTime TEXT NOT NULL,
        servingSize TEXT NOT NULL,
        category TEXT NOT NULL,
        description TEXT NOT NULL,
        equipment TEXT NOT NULL,
        coffeeAmount TEXT NOT NULL,
        waterAmount TEXT NOT NULL,
        temperature TEXT NOT NULL,
        grindSize TEXT NOT NULL,
        steps TEXT NOT NULL,
        sweetness REAL DEFAULT 3.0,
        acidity REAL DEFAULT 3.0,
        bitterness REAL DEFAULT 3.0,
        body REAL DEFAULT 3.0,
        aroma REAL DEFAULT 3.0,
        bestBeans TEXT,
        tips TEXT,
        imagePath TEXT,
        isFavorite INTEGER DEFAULT 0,
        createdAt TEXT NOT NULL
      )
    ''');

    // Coffee Beans table
    await db.execute('''
      CREATE TABLE coffee_beans (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        origin TEXT NOT NULL,
        type TEXT NOT NULL,
        roastLevel TEXT NOT NULL,
        flavorNotes TEXT NOT NULL,
        sweetness REAL DEFAULT 3.0,
        acidity REAL DEFAULT 3.0,
        body REAL DEFAULT 3.0,
        complexity REAL DEFAULT 3.0,
        processing TEXT,
        altitude TEXT,
        description TEXT NOT NULL,
        bestMethods TEXT,
        characteristics TEXT,
        isFavorite INTEGER DEFAULT 0,
        createdAt TEXT NOT NULL
      )
    ''');

    // Glossary Terms table
    await db.execute('''
      CREATE TABLE glossary_terms (
        id TEXT PRIMARY KEY,
        term TEXT NOT NULL,
        definition TEXT NOT NULL,
        category TEXT NOT NULL,
        example TEXT,
        relatedTerms TEXT,
        createdAt TEXT NOT NULL
      )
    ''');

    // Quizzes table
    await db.execute('''
      CREATE TABLE quizzes (
        id TEXT PRIMARY KEY,
        question TEXT NOT NULL,
        options TEXT NOT NULL,
        correctAnswerIndex INTEGER NOT NULL,
        explanation TEXT NOT NULL,
        category TEXT NOT NULL,
        difficulty TEXT NOT NULL,
        quizType TEXT DEFAULT 'text',
        imagePath TEXT,
        createdAt TEXT NOT NULL
      )
    ''');

    // Quiz Results table
    await db.execute('''
      CREATE TABLE quiz_results (
        id TEXT PRIMARY KEY,
        quizId TEXT NOT NULL,
        selectedAnswerIndex INTEGER NOT NULL,
        isCorrect INTEGER NOT NULL,
        completedAt TEXT NOT NULL,
        FOREIGN KEY (quizId) REFERENCES quizzes (id) ON DELETE CASCADE
      )
    ''');

    // Learning Progress table
    await db.execute('''
      CREATE TABLE learning_progress (
        id TEXT PRIMARY KEY,
        methodsLearned INTEGER DEFAULT 0,
        quizzesCompleted INTEGER DEFAULT 0,
        correctAnswers INTEGER DEFAULT 0,
        totalQuizAttempts INTEGER DEFAULT 0,
        favoriteMethods INTEGER DEFAULT 0,
        favoriteBeans INTEGER DEFAULT 0,
        achievements TEXT,
        completedCategories TEXT,
        lastActive TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');

    // User Preferences table
    await db.execute('''
      CREATE TABLE user_preferences (
        id INTEGER PRIMARY KEY CHECK (id = 1),
        theme TEXT NOT NULL DEFAULT 'system',
        showIntro INTEGER DEFAULT 1,
        temperatureUnit TEXT DEFAULT 'celsius',
        volumeUnit TEXT DEFAULT 'ml',
        language TEXT DEFAULT 'en'
      )
    ''');

    // Insert default preferences
    await db.insert('user_preferences', {
      'id': 1,
      'theme': 'system',
      'showIntro': 1,
      'temperatureUnit': 'celsius',
      'volumeUnit': 'ml',
      'language': 'en',
    });

    // Insert default learning progress
    await db.insert('learning_progress', {
      'id': '1',
      'methodsLearned': 0,
      'quizzesCompleted': 0,
      'correctAnswers': 0,
      'totalQuizAttempts': 0,
      'favoriteMethods': 0,
      'favoriteBeans': 0,
      'achievements': '',
      'completedCategories': '',
      'lastActive': DateTime.now().toIso8601String(),
      'createdAt': DateTime.now().toIso8601String(),
    });
  }

  // ============================================================
  // BREW METHOD OPERATIONS
  // ============================================================

  Future<void> insertBrewMethod(BrewMethod method) async {
    final db = await database;
    await db.insert('brew_methods', method.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<BrewMethod>> getAllBrewMethods() async {
    final db = await database;
    final maps = await db.query('brew_methods', orderBy: 'name ASC');
    return maps.map((map) => BrewMethod.fromMap(map)).toList();
  }

  Future<List<BrewMethod>> getBrewMethodsByCategory(String category) async {
    final db = await database;
    final maps = await db.query(
      'brew_methods',
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'name ASC',
    );
    return maps.map((map) => BrewMethod.fromMap(map)).toList();
  }

  Future<List<BrewMethod>> getBrewMethodsByDifficulty(String difficulty) async {
    final db = await database;
    final maps = await db.query(
      'brew_methods',
      where: 'difficulty = ?',
      whereArgs: [difficulty],
      orderBy: 'name ASC',
    );
    return maps.map((map) => BrewMethod.fromMap(map)).toList();
  }

  Future<List<BrewMethod>> getFavoriteBrewMethods() async {
    final db = await database;
    final maps = await db.query(
      'brew_methods',
      where: 'isFavorite = ?',
      whereArgs: [1],
      orderBy: 'name ASC',
    );
    return maps.map((map) => BrewMethod.fromMap(map)).toList();
  }

  Future<BrewMethod?> getBrewMethod(String id) async {
    final db = await database;
    final maps = await db.query(
      'brew_methods',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return BrewMethod.fromMap(maps.first);
  }

  Future<int> updateBrewMethod(BrewMethod method) async {
    final db = await database;
    return await db.update(
      'brew_methods',
      method.toMap(),
      where: 'id = ?',
      whereArgs: [method.id],
    );
  }

  Future<int> toggleBrewMethodFavorite(String id, bool isFavorite) async {
    final db = await database;
    return await db.update(
      'brew_methods',
      {'isFavorite': isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<BrewMethod>> searchBrewMethods(String query) async {
    final db = await database;
    final maps = await db.query(
      'brew_methods',
      where: 'name LIKE ? OR description LIKE ? OR origin LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
      orderBy: 'name ASC',
    );
    return maps.map((map) => BrewMethod.fromMap(map)).toList();
  }

  Future<BrewMethod?> getRandomBrewMethod() async {
    final db = await database;
    final maps = await db.query(
      'brew_methods',
      orderBy: 'RANDOM()',
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return BrewMethod.fromMap(maps.first);
  }

  // ============================================================
  // COFFEE BEAN OPERATIONS
  // ============================================================

  Future<void> insertCoffeeBean(CoffeeBean bean) async {
    final db = await database;
    await db.insert('coffee_beans', bean.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CoffeeBean>> getAllCoffeeBeans() async {
    final db = await database;
    final maps = await db.query('coffee_beans', orderBy: 'name ASC');
    return maps.map((map) => CoffeeBean.fromMap(map)).toList();
  }

  Future<List<CoffeeBean>> getCoffeeBeansByType(String type) async {
    final db = await database;
    final maps = await db.query(
      'coffee_beans',
      where: 'type = ?',
      whereArgs: [type],
      orderBy: 'name ASC',
    );
    return maps.map((map) => CoffeeBean.fromMap(map)).toList();
  }

  Future<List<CoffeeBean>> getCoffeeBeansByOrigin(String origin) async {
    final db = await database;
    final maps = await db.query(
      'coffee_beans',
      where: 'origin = ?',
      whereArgs: [origin],
      orderBy: 'name ASC',
    );
    return maps.map((map) => CoffeeBean.fromMap(map)).toList();
  }

  Future<List<CoffeeBean>> getFavoriteCoffeeBeans() async {
    final db = await database;
    final maps = await db.query(
      'coffee_beans',
      where: 'isFavorite = ?',
      whereArgs: [1],
      orderBy: 'name ASC',
    );
    return maps.map((map) => CoffeeBean.fromMap(map)).toList();
  }

  Future<CoffeeBean?> getCoffeeBean(String id) async {
    final db = await database;
    final maps = await db.query(
      'coffee_beans',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return CoffeeBean.fromMap(maps.first);
  }

  Future<int> updateCoffeeBean(CoffeeBean bean) async {
    final db = await database;
    return await db.update(
      'coffee_beans',
      bean.toMap(),
      where: 'id = ?',
      whereArgs: [bean.id],
    );
  }

  Future<int> toggleCoffeeBeanFavorite(String id, bool isFavorite) async {
    final db = await database;
    return await db.update(
      'coffee_beans',
      {'isFavorite': isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<CoffeeBean>> searchCoffeeBeans(String query) async {
    final db = await database;
    final maps = await db.query(
      'coffee_beans',
      where: 'name LIKE ? OR description LIKE ? OR origin LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
      orderBy: 'name ASC',
    );
    return maps.map((map) => CoffeeBean.fromMap(map)).toList();
  }

  // ============================================================
  // GLOSSARY OPERATIONS
  // ============================================================

  Future<void> insertGlossaryTerm(GlossaryTerm term) async {
    final db = await database;
    await db.insert('glossary_terms', term.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<GlossaryTerm>> getAllGlossaryTerms() async {
    final db = await database;
    final maps = await db.query('glossary_terms', orderBy: 'term ASC');
    return maps.map((map) => GlossaryTerm.fromMap(map)).toList();
  }

  Future<List<GlossaryTerm>> getGlossaryTermsByCategory(String category) async {
    final db = await database;
    final maps = await db.query(
      'glossary_terms',
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'term ASC',
    );
    return maps.map((map) => GlossaryTerm.fromMap(map)).toList();
  }

  Future<GlossaryTerm?> getGlossaryTerm(String id) async {
    final db = await database;
    final maps = await db.query(
      'glossary_terms',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return GlossaryTerm.fromMap(maps.first);
  }

  Future<List<GlossaryTerm>> searchGlossaryTerms(String query) async {
    final db = await database;
    final maps = await db.query(
      'glossary_terms',
      where: 'term LIKE ? OR definition LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'term ASC',
    );
    return maps.map((map) => GlossaryTerm.fromMap(map)).toList();
  }

  // ============================================================
  // QUIZ OPERATIONS
  // ============================================================

  Future<void> insertQuiz(QuizData quiz) async {
    final db = await database;
    await db.insert('quizzes', quiz.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<QuizData>> getAllQuizzes() async {
    final db = await database;
    final maps = await db.query('quizzes', orderBy: 'category ASC');
    return maps.map((map) => QuizData.fromMap(map)).toList();
  }

  Future<List<QuizData>> getQuizzesByCategory(String category) async {
    final db = await database;
    final maps = await db.query(
      'quizzes',
      where: 'category = ?',
      whereArgs: [category],
    );
    return maps.map((map) => QuizData.fromMap(map)).toList();
  }

  Future<List<QuizData>> getQuizzesByDifficulty(String difficulty) async {
    final db = await database;
    final maps = await db.query(
      'quizzes',
      where: 'difficulty = ?',
      whereArgs: [difficulty],
    );
    return maps.map((map) => QuizData.fromMap(map)).toList();
  }

  Future<QuizData?> getQuiz(String id) async {
    final db = await database;
    final maps = await db.query(
      'quizzes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return QuizData.fromMap(maps.first);
  }

  Future<List<QuizData>> getRandomQuizzes(int count) async {
    final db = await database;
    final maps = await db.query(
      'quizzes',
      orderBy: 'RANDOM()',
      limit: count,
    );
    return maps.map((map) => QuizData.fromMap(map)).toList();
  }

  Future<void> insertQuizResult(QuizResult result) async {
    final db = await database;
    await db.insert('quiz_results', result.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<QuizResult>> getQuizResults() async {
    final db = await database;
    final maps = await db.query('quiz_results', orderBy: 'completedAt DESC');
    return maps.map((map) => QuizResult.fromMap(map)).toList();
  }

  // ============================================================
  // LEARNING PROGRESS OPERATIONS
  // ============================================================

  Future<LearningProgress> getLearningProgress() async {
    final db = await database;
    final maps = await db.query('learning_progress', where: 'id = ?', whereArgs: ['1']);

    if (maps.isEmpty) {
      final defaultProgress = LearningProgress(
        id: '1',
        lastActive: DateTime.now(),
        createdAt: DateTime.now(),
      );
      await db.insert('learning_progress', defaultProgress.toMap());
      return defaultProgress;
    }

    return LearningProgress.fromMap(maps.first);
  }

  Future<int> updateLearningProgress(LearningProgress progress) async {
    final db = await database;
    return await db.update(
      'learning_progress',
      progress.toMap(),
      where: 'id = ?',
      whereArgs: [progress.id],
    );
  }

  Future<void> incrementMethodsLearned() async {
    final progress = await getLearningProgress();
    await updateLearningProgress(progress.copyWith(
      methodsLearned: progress.methodsLearned + 1,
      lastActive: DateTime.now(),
    ));
  }

  Future<void> incrementQuizCompleted(bool isCorrect) async {
    final progress = await getLearningProgress();
    await updateLearningProgress(progress.copyWith(
      quizzesCompleted: progress.quizzesCompleted + 1,
      correctAnswers: isCorrect ? progress.correctAnswers + 1 : progress.correctAnswers,
      totalQuizAttempts: progress.totalQuizAttempts + 1,
      lastActive: DateTime.now(),
    ));
  }

  Future<void> addAchievement(String achievement) async {
    final progress = await getLearningProgress();
    if (!progress.achievements.contains(achievement)) {
      final updatedAchievements = [...progress.achievements, achievement];
      await updateLearningProgress(progress.copyWith(
        achievements: updatedAchievements,
        lastActive: DateTime.now(),
      ));
    }
  }

  // ============================================================
  // USER PREFERENCES OPERATIONS
  // ============================================================

  Future<UserPreferences> getUserPreferences() async {
    final db = await database;
    final maps = await db.query('user_preferences', where: 'id = 1');

    if (maps.isEmpty) {
      return UserPreferences();
    }

    return UserPreferences.fromMap(maps.first);
  }

  Future<int> updateUserPreferences(UserPreferences preferences) async {
    final db = await database;
    return await db.update(
      'user_preferences',
      preferences.toMap(),
      where: 'id = 1',
    );
  }

  // ============================================================
  // ANALYTICS & STATISTICS
  // ============================================================

  Future<int> getTotalBrewMethods() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM brew_methods');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> getTotalCoffeeBeans() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM coffee_beans');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> getTotalGlossaryTerms() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM glossary_terms');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> getTotalQuizzes() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM quizzes');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<Map<String, int>> getMethodCountByCategory() async {
    final db = await database;
    final maps = await db.rawQuery('''
      SELECT category, COUNT(*) as count
      FROM brew_methods
      GROUP BY category
    ''');

    Map<String, int> result = {};
    for (var map in maps) {
      result[map['category'] as String] = map['count'] as int;
    }
    return result;
  }

  // ============================================================
  // RESET & CLEANUP OPERATIONS
  // ============================================================

  Future<void> resetAllData() async {
    final db = await database;
    await db.delete('brew_methods');
    await db.delete('coffee_beans');
    await db.delete('glossary_terms');
    await db.delete('quizzes');
    await db.delete('quiz_results');
    await db.delete('learning_progress');
    await db.update('user_preferences', UserPreferences().toMap(), where: 'id = 1');

    // Re-insert default learning progress
    await db.insert('learning_progress', {
      'id': '1',
      'methodsLearned': 0,
      'quizzesCompleted': 0,
      'correctAnswers': 0,
      'totalQuizAttempts': 0,
      'favoriteMethods': 0,
      'favoriteBeans': 0,
      'achievements': '',
      'completedCategories': '',
      'lastActive': DateTime.now().toIso8601String(),
      'createdAt': DateTime.now().toIso8601String(),
    });
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }

  // ============================================================
  // SEED DATABASE
  // ============================================================

  Future<void> seedDatabase() async {
    // Check if data needs updating
    final methods = await getAllBrewMethods();
    final beans = await getAllCoffeeBeans();
    final glossary = await getAllGlossaryTerms();
    final quizzes = await getAllQuizzes();

    // If content count is low, reseed everything
    final needsUpdate = methods.length < 40 || beans.length < 80 || glossary.length < 150 || quizzes.length < 800;

    if (!needsUpdate) {
      return; // Already seeded with sufficient data
    }

    // Clear existing data before reseeding
    final db = await database;
    await db.delete('brew_methods');
    await db.delete('coffee_beans');
    await db.delete('glossary_terms');
    await db.delete('quizzes');

    // Insert seed data using batch operations for performance
    final batch = db.batch();

    // Insert brew methods
    final seedMethods = ContentSeed.getBrewMethods();
    for (final method in seedMethods) {
      batch.insert('brew_methods', method.toMap());
    }

    // Insert coffee beans
    final seedBeans = ContentSeed.getCoffeeBeans();
    for (final bean in seedBeans) {
      batch.insert('coffee_beans', bean.toMap());
    }

    // Insert glossary terms
    final seedGlossary = ContentSeed.getGlossaryTerms();
    for (final term in seedGlossary) {
      batch.insert('glossary_terms', term.toMap());
    }

    // Insert quizzes
    final seedQuizzes = ContentSeed.getQuizzes();
    for (final quiz in seedQuizzes) {
      batch.insert('quizzes', quiz.toMap());
    }

    await batch.commit(noResult: true);
  }
}

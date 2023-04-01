import 'package:recipes/app/data/model/favorite_model.dart';
import 'package:recipes/app/data/model/search_history_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbService {
  static Future<Database> _getDatabase() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, 'recipe.db');
    final Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Create Likes table for Favorite Recipes
        await db.execute(
          'CREATE TABLE likes (id INTEGER PRIMARY KEY, recipeId TEXT, label TEXT, image TEXT)',
        );

        // Create History table for Search History
        await db.execute(
          'CREATE TABLE history (id INTEGER PRIMARY KEY, query TEXT)',
        );
      },
    );

    return database;
  }

  // Save Recipe Like to DB (Favorite Recipe)
  static Future<bool> saveLike(String recipeId, String label, String image) async {
    final Database db = await _getDatabase();

    int insertId = await db.insert(
      'likes',
      {
        'recipeId': recipeId,
        'label': label,
        'image': image,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return insertId > 0;
  }

  // Remove Recipe Like from DB
  static Future<bool> removeLike(String recipeId) async {
    final Database db = await _getDatabase();

    int affectedRows = await db.delete(
      'likes',
      where: 'recipeId = ?',
      whereArgs: [
        recipeId
      ],
    );

    return affectedRows > 0;
  }

  // Get Specific Recipe Like from DB
  static Future<Map<String, dynamic>?> getLike(String recipeId) async {
    final Database db = await _getDatabase();

    final List<Map<String, dynamic>> likes = await db.query(
      'likes',
      where: 'recipeId = ?',
      whereArgs: [
        recipeId
      ],
      limit: 1,
    );

    if (likes.isNotEmpty) {
      return likes.first;
    } else {
      return null;
    }
  }

  // Get Recipe Likes from DB
  static Future<List<FavoriteModel>> getLikes(int limit, int offset) async {
    final Database db = await _getDatabase();

    final List<Map<String, dynamic>> likes = await db.query(
      'likes',
      orderBy: 'id DESC',
      limit: limit,
      offset: offset,
    );

    return List.generate(likes.length, (i) {
      return FavoriteModel(
        id: likes[i]['id'],
        recipeId: likes[i]['recipeId'],
        label: likes[i]['label'],
        image: likes[i]['image'],
      );
    });
  }

  // Save Search to DB
  static Future<bool> saveSearch(String query) async {
    final Database db = await _getDatabase();

    // Delete query if exists, so we can replace fresh query
    await db.delete(
      'history',
      where: 'query = ?',
      whereArgs: [
        query
      ],
    );

    int insertId = await db.insert(
      'history',
      {
        'query': query
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return insertId > 0;
  }

  // Remove Search from DB
  static Future<bool> removeSearch(int id) async {
    final Database db = await _getDatabase();

    int affectedRows = await db.delete(
      'history',
      where: 'id = ?',
      whereArgs: [
        id
      ],
    );

    return affectedRows > 0;
  }

  // Get Search History from DB
  static Future<List<SearchHistoryModel>> getSearchHistory() async {
    final Database db = await _getDatabase();

    final List<Map<String, dynamic>> history = await db.query(
      'history',
      orderBy: 'id DESC',
    );

    return List.generate(history.length, (i) {
      return SearchHistoryModel(
        id: history[i]['id'],
        query: history[i]['query'],
      );
    });
  }
}

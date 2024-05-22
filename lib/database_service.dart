import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  DatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'kutuphane.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Users (
            user_id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_name TEXT UNIQUE,
            password TEXT,
            email TEXT UNIQUE,
            role TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Books (
            book_id INTEGER PRIMARY KEY AUTOINCREMENT,
            book_name TEXT UNIQUE,
            book_author TEXT,
            book_category TEXT,
            owner_id INTEGER,
            FOREIGN KEY(owner_id) REFERENCES Users(user_id)
          )
        ''');
      },
    );
  }
Future<String?> getEmailByUsername(String username) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT email FROM Users WHERE user_name = ?',
      [username]
    );

    if (result.isNotEmpty) {
      return result.first['email'] as String?;
    } else {
      return null;
    }
  }
Future<void> addBook(String bookName, String bookAuthor, String bookCategory) async {
    final db = await database;
    await db.rawInsert(
      'INSERT INTO Books (book_name, book_author, book_category, owner_id) VALUES (?, ?, ?, ?)',
      [bookName, bookAuthor, bookCategory, 0]
    );
  }

  Future<void> removeBook(int bookId) async {
    final db = await database;
    await db.rawDelete('DELETE FROM Books WHERE book_id = ?', [bookId]);
  }

  Future<List<Map<String, dynamic>>> getAllBooks() async {
    final db = await database;
    return await db.rawQuery('SELECT * FROM Books');
  }

  Future<void> addUser(String userName, String password, String email, String role) async {
    final db = await database;
    
    // Check if user_name or email already exists
    final userNameResult = await db.rawQuery('SELECT * FROM Users WHERE user_name = ?', [userName]);
    if (userNameResult.isNotEmpty) {
      throw Exception('User name already exists');
    }

    final emailResult = await db.rawQuery('SELECT * FROM Users WHERE email = ?', [email]);
    if (emailResult.isNotEmpty) {
      throw Exception('Email already exists');
    }
    
    await db.rawInsert(
      'INSERT INTO Users (user_name, password, email, role) VALUES (?, ?, ?, ?)',
      [userName, password, email, role]
    );
  }

  Future<String?> login(String userName, String password) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT role FROM Users WHERE user_name = ? AND password = ?',
      [userName, password]
    );

    if (result.isNotEmpty) {
      return result.first['role'] as String;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.rawQuery('SELECT * FROM Users');
  }
}

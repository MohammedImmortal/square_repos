import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/repository.dart';

class LocalRepository {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'repos.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE repos(id INTEGER PRIMARY KEY, name TEXT, description TEXT, owner TEXT, isFork INTEGER, repoUrl TEXT, ownerUrl TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertRepos(List<RepositoryModel> repos) async {
    final db = await database;
    for (var repo in repos) {
      await db.insert(
        'repos',
        {
          'name': repo.name,
          'description': repo.description,
          'owner': repo.owner,
          'isFork': repo.isFork ? 1 : 0,
          'repoUrl': repo.repoUrl,
          'ownerUrl': repo.ownerUrl,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<RepositoryModel>> fetchRepos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('repos');

    return List.generate(maps.length, (i) {
      return RepositoryModel(
        name: maps[i]['name'],
        description: maps[i]['description'],
        owner: maps[i]['owner'],
        isFork: maps[i]['isFork'] == 1,
        repoUrl: maps[i]['repoUrl'],
        ownerUrl: maps[i]['ownerUrl'],
      );
    });
  }

  Future<void> clearRepos() async {
    final db = await database;
    await db.delete('repos');
  }
}

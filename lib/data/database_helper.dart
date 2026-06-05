import 'dart:convert';
import 'dart:io' show Platform, Directory;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final home =
        Platform.environment['HOME'] ?? '/home/${Platform.environment['USER']}';
    final dbDir = Directory('$home/.essence_data');
    if (!await dbDir.exists()) {
      await dbDir.create(recursive: true);
    }
    final dbPath = join(dbDir.path, 'essence.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        senha_hash TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE consultas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id INTEGER NOT NULL,
        data TEXT NOT NULL,
        emocao TEXT NOT NULL,
        lugar TEXT NOT NULL,
        elemento TEXT NOT NULL,
        cor TEXT NOT NULL,
        resultado_json TEXT NOT NULL,
        FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
      )
    ''');
    await db.execute('''
      CREATE TABLE favoritos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id INTEGER NOT NULL,
        perfume_id TEXT NOT NULL,
        FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
      )
    ''');
  }

  String _hashSenha(String senha) {
    final bytes = utf8.encode(senha);
    return sha256.convert(bytes).toString();
  }

  Future<int> inserirUsuario(String nome, String email, String senha) async {
    final db = await database;
    final hash = _hashSenha(senha);
    return await db.insert('usuarios', {
      'nome': nome,
      'email': email,
      'senha_hash': hash,
    });
  }

  Future<Map<String, dynamic>?> login(String email, String senha) async {
    final db = await database;
    final hash = _hashSenha(senha);
    final results = await db.query(
      'usuarios',
      where: 'email = ? AND senha_hash = ?',
      whereArgs: [email, hash],
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> inserirConsulta(int usuarioId, String emocao, String lugar,
      String elemento, String cor, String resultadoJson) async {
    final db = await database;
    return await db.insert('consultas', {
      'usuario_id': usuarioId,
      'data': DateTime.now().toIso8601String(),
      'emocao': emocao,
      'lugar': lugar,
      'elemento': elemento,
      'cor': cor,
      'resultado_json': resultadoJson,
    });
  }

  Future<List<Map<String, dynamic>>> listarConsultas(int usuarioId) async {
    final db = await database;
    return await db.query(
      'consultas',
      where: 'usuario_id = ?',
      whereArgs: [usuarioId],
      orderBy: 'data DESC',
    );
  }

  Future<int> atualizarConsulta(int id, String emocao, String lugar,
      String elemento, String cor, String resultadoJson) async {
    final db = await database;
    return await db.update(
      'consultas',
      {
        'emocao': emocao,
        'lugar': lugar,
        'elemento': elemento,
        'cor': cor,
        'resultado_json': resultadoJson,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> excluirConsulta(int id) async {
    final db = await database;
    return await db.delete('consultas', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> favoritar(int usuarioId, String perfumeId) async {
    final db = await database;
    final existente = await db.query('favoritos',
        where: 'usuario_id = ? AND perfume_id = ?',
        whereArgs: [usuarioId, perfumeId]);
    if (existente.isEmpty) {
      await db.insert('favoritos', {
        'usuario_id': usuarioId,
        'perfume_id': perfumeId,
      });
    }
  }

  Future<void> desfavoritar(int usuarioId, String perfumeId) async {
    final db = await database;
    await db.delete('favoritos',
        where: 'usuario_id = ? AND perfume_id = ?',
        whereArgs: [usuarioId, perfumeId]);
  }

  Future<List<String>> listarFavoritos(int usuarioId) async {
    final db = await database;
    final result = await db.query('favoritos',
        columns: ['perfume_id'],
        where: 'usuario_id = ?',
        whereArgs: [usuarioId]);
    return result.map((row) => row['perfume_id'] as String).toList();
  }
}

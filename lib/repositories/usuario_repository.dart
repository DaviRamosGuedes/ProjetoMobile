import 'package:sqflite/sqflite.dart';
import 'database.dart';
import '../models/usuario_model.dart';

class UsuarioRepository {
  Future<void> insert(UsuarioModel usuario) async {
    final db = await AppDatabase.instance;
    usuario.ultimaAlteracao = DateTime.now();
    await db.insert(
      'usuarios',
      usuario.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<UsuarioModel>> getAll() async {
    final db = await AppDatabase.instance;
    final result = await db.query('usuarios');
    return result.map((e) => UsuarioModel.fromJson(e)).toList();
  }

  Future<UsuarioModel?> getById(int id) async {
    final db = await AppDatabase.instance;
    final result = await db.query('usuarios', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) return UsuarioModel.fromJson(result.first);
    return null;
  }

  Future<void> update(UsuarioModel usuario) async {
    final db = await AppDatabase.instance;
    usuario.ultimaAlteracao = DateTime.now();
    await db.update(
      'usuarios',
      usuario.toJson(),
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await AppDatabase.instance;
    await db.delete('usuarios', where: 'id = ?', whereArgs: [id]);
  }
}

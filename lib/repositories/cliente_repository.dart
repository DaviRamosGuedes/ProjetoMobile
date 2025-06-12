import 'package:sqflite/sqflite.dart';
import 'database.dart';
import '../models/cliente_model.dart';

class ClienteRepository {
  Future<void> insert(ClienteModel cliente) async {
    final db = await AppDatabase.instance;
    cliente.ultimaAlteracao = DateTime.now();
    await db.insert(
      'clientes',
      cliente.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ClienteModel>> getAll() async {
    final db = await AppDatabase.instance;
    final result = await db.query('clientes', where: 'excluido = 0');
    return result.map((e) => ClienteModel.fromJson(e)).toList();
  }

  Future<ClienteModel?> getById(int id) async {
    final db = await AppDatabase.instance;
    final result = await db.query('clientes', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) return ClienteModel.fromJson(result.first);
    return null;
  }

  Future<void> update(ClienteModel cliente) async {
    final db = await AppDatabase.instance;
    cliente.ultimaAlteracao = DateTime.now();
    await db.update(
      'clientes',
      cliente.toJson(),
      where: 'id = ?',
      whereArgs: [cliente.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await AppDatabase.instance;
    await db.update(
      'clientes',
      {'excluido': 1, 'ultimaAlteracao': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

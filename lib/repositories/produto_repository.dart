import 'package:sqflite/sqflite.dart';
import 'database.dart';
import '../models/produto_model.dart';

class ProdutoRepository {
  Future<void> insert(ProdutoModel produto) async {
    final db = await AppDatabase.instance;
    produto.ultimaAlteracao = DateTime.now();
    await db.insert(
      'produtos',
      produto.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ProdutoModel>> getAll() async {
    final db = await AppDatabase.instance;
    final result = await db.query('produtos');
    return result.map((e) => ProdutoModel.fromJson(e)).toList();
  }

  Future<ProdutoModel?> getById(int id) async {
    final db = await AppDatabase.instance;
    final result = await db.query('produtos', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) return ProdutoModel.fromJson(result.first);
    return null;
  }

  Future<void> update(ProdutoModel produto) async {
    final db = await AppDatabase.instance;
    produto.ultimaAlteracao = DateTime.now();
    await db.update(
      'produtos',
      produto.toJson(),
      where: 'id = ?',
      whereArgs: [produto.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await AppDatabase.instance;
    await db.delete('produtos', where: 'id = ?', whereArgs: [id]);
  }
}

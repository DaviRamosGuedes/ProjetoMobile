import 'package:sqflite/sqflite.dart';
import 'database.dart';
import '../models/pedido_model.dart';
import '../models/pedido_item_model.dart';
import '../models/pedido_pagamento_model.dart';

class PedidoRepository {
  Future<void> insert(PedidoModel pedido) async {
    final db = await AppDatabase.instance;
    pedido.ultimaAlteracao = DateTime.now();

    int pedidoId = await db.insert(
      'pedidos',
      pedido.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    for (var item in pedido.itens) {
      item.idPedido = pedidoId;
      await db.insert(
        'pedido_itens',
        item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    for (var pagamento in pedido.pagamentos) {
      pagamento.idPedido = pedidoId;
      await db.insert(
        'pedido_pagamentos',
        pagamento.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<PedidoModel>> getAll() async {
    final db = await AppDatabase.instance;
    final pedidosRaw = await db.query('pedidos');
    List<PedidoModel> pedidos = [];

    for (var pedidoMap in pedidosRaw) {
      int id = pedidoMap['id'] as int;

      final itensRaw = await db.query(
        'pedido_itens',
        where: 'idPedido = ?',
        whereArgs: [id],
      );
      final pagamentosRaw = await db.query(
        'pedido_pagamentos',
        where: 'idPedido = ?',
        whereArgs: [id],
      );

      pedidos.add(
        PedidoModel(
          id: id,
          idCliente: pedidoMap['idCliente'] as int,
          idUsuario: pedidoMap['idUsuario'] as int,
          totalPedido: (pedidoMap['totalPedido'] as num).toDouble(),
          ultimaAlteracao:
              pedidoMap['ultimaAlteracao'] != null
                  ? DateTime.tryParse(pedidoMap['ultimaAlteracao'].toString())
                  : null,
          itens: itensRaw.map((e) => PedidoItemModel.fromJson(e)).toList(),
          pagamentos:
              pagamentosRaw
                  .map((e) => PedidoPagamentoModel.fromJson(e))
                  .toList(),
        ),
      );
    }

    return pedidos;
  }

  Future<void> delete(int id) async {
    final db = await AppDatabase.instance;
    await db.delete('pedido_itens', where: 'idPedido = ?', whereArgs: [id]);
    await db.delete(
      'pedido_pagamentos',
      where: 'idPedido = ?',
      whereArgs: [id],
    );
    await db.delete('pedidos', where: 'id = ?', whereArgs: [id]);
  }
}

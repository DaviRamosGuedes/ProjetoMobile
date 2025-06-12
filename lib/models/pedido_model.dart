import 'pedido_item_model.dart';
import 'pedido_pagamento_model.dart';

class PedidoModel {
  int? id;
  int idCliente;
  int idUsuario;
  double totalPedido;
  DateTime? ultimaAlteracao;
  List<PedidoItemModel> itens;
  List<PedidoPagamentoModel> pagamentos;

  PedidoModel({
    this.id,
    required this.idCliente,
    required this.idUsuario,
    required this.totalPedido,
    this.ultimaAlteracao,
    required this.itens,
    required this.pagamentos,
  });

  factory PedidoModel.fromJson(Map<String, dynamic> json) {
    return PedidoModel(
      id: json['id'],
      idCliente: json['idCliente'],
      idUsuario: json['idUsuario'],
      totalPedido: json['totalPedido'].toDouble(),
      ultimaAlteracao:
          json['ultimaAlteracao'] != null
              ? DateTime.parse(json['ultimaAlteracao'])
              : null,
      itens:
          (json['itens'] as List)
              .map((item) => PedidoItemModel.fromJson(item))
              .toList(),
      pagamentos:
          (json['pagamentos'] as List)
              .map((pag) => PedidoPagamentoModel.fromJson(pag))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idCliente': idCliente,
      'idUsuario': idUsuario,
      'totalPedido': totalPedido,
      'ultimaAlteracao': ultimaAlteracao?.toIso8601String(),
      'itens': itens.map((item) => item.toJson()).toList(),
      'pagamentos': pagamentos.map((pag) => pag.toJson()).toList(),
    };
  }
}

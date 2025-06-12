class PedidoPagamentoModel {
  int? id;
  int idPedido;
  double valor;

  PedidoPagamentoModel({this.id, required this.idPedido, required this.valor});

  factory PedidoPagamentoModel.fromJson(Map<String, dynamic> json) {
    return PedidoPagamentoModel(
      id: json['id'],
      idPedido: json['idPedido'],
      valor: json['valor'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'idPedido': idPedido, 'valor': valor};
  }
}

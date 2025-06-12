class PedidoItemModel {
  int? id;
  int idPedido;
  int idProduto;
  double quantidade;
  double totalItem;

  PedidoItemModel({
    this.id,
    required this.idPedido,
    required this.idProduto,
    required this.quantidade,
    required this.totalItem,
  });

  factory PedidoItemModel.fromJson(Map<String, dynamic> json) {
    return PedidoItemModel(
      id: json['id'],
      idPedido: json['idPedido'],
      idProduto: json['idProduto'],
      quantidade: json['quantidade'].toDouble(),
      totalItem: json['totalItem'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idPedido': idPedido,
      'idProduto': idProduto,
      'quantidade': quantidade,
      'totalItem': totalItem,
    };
  }
}

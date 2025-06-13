class ProdutoModel {
  int? id;
  String nome;
  String unidade;
  double qtdEstoque;
  double precoVenda;
  int status;
  double? custo;
  String? codigoBarra;
  DateTime? ultimaAlteracao;
  int excluido;

  ProdutoModel({
    this.id,
    required this.nome,
    required this.unidade,
    required this.qtdEstoque,
    required this.precoVenda,
    required this.status,
    this.custo,
    this.codigoBarra,
    this.ultimaAlteracao,
    this.excluido = 0,
  });

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()),
      nome: json['nome'] ?? '',
      unidade: json['unidade'] ?? '',
      qtdEstoque: (json['qtdEstoque'] as num).toDouble(),
      precoVenda: (json['precoVenda'] as num).toDouble(),
      status:
          json['status'] is int
              ? json['status']
              : int.tryParse(json['status'].toString()) ?? 0,
      custo: json['custo'] != null ? (json['custo'] as num).toDouble() : null,
      codigoBarra: json['codigoBarra'],
      ultimaAlteracao:
          json['ultimaAlteracao'] != null
              ? DateTime.tryParse(json['ultimaAlteracao'])
              : null,
      excluido: json['excluido'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'unidade': unidade,
      'qtdEstoque': qtdEstoque,
      'precoVenda': precoVenda,
      'status': status,
      'custo': custo,
      'codigoBarra': codigoBarra,
      'ultimaAlteracao': ultimaAlteracao?.toIso8601String(),
      'excluido': excluido,
    };
  }
}

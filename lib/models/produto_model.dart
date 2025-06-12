class ProdutoModel {
  int? id;
  String nome;
  String unidade; // un, cx, kg, lt, ml
  double qtdEstoque;
  double precoVenda;
  int status; // 0 - ativo, 1 - inativo
  double? custo;
  String? codigoBarra;
  DateTime? ultimaAlteracao;

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
  });

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      id: json['id'],
      nome: json['nome'],
      unidade: json['unidade'],
      qtdEstoque: json['qtdEstoque'].toDouble(),
      precoVenda: json['precoVenda'].toDouble(),
      status: json['Status'],
      custo: json['custo']?.toDouble(),
      codigoBarra: json['codigoBarra'],
      ultimaAlteracao:
          json['ultimaAlteracao'] != null
              ? DateTime.parse(json['ultimaAlteracao'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'unidade': unidade,
      'qtdEstoque': qtdEstoque,
      'precoVenda': precoVenda,
      'Status': status,
      'custo': custo,
      'codigoBarra': codigoBarra,
      'ultimaAlteracao': ultimaAlteracao?.toIso8601String(),
    };
  }
}

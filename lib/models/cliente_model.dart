class ClienteModel {
  int? id;
  String nome;
  String tipo;
  String cpfCnpj;
  String? email, telefone, cep, endereco, bairro, cidade, uf;
  DateTime? ultimaAlteracao;
  int excluido;

  ClienteModel({
    this.id,
    required this.nome,
    required this.tipo,
    required this.cpfCnpj,
    this.email,
    this.telefone,
    this.cep,
    this.endereco,
    this.bairro,
    this.cidade,
    this.uf,
    this.ultimaAlteracao,
    this.excluido = 0,
  });

  factory ClienteModel.fromJson(Map<String, dynamic> json) {
    return ClienteModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()),
      nome: json['nome'] ?? '',
      tipo: json['tipo'] ?? '',
      cpfCnpj: json['cpfCnpj'] ?? '',
      email: json['email'],
      telefone: json['telefone'],
      cep: json['cep'],
      endereco: json['endereco'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      uf: json['uf'],
      ultimaAlteracao:
          json['ultimaAlteracao'] != null
              ? DateTime.tryParse(json['ultimaAlteracao'])
              : null,
      excluido:
          json['excluido'] is int
              ? json['excluido']
              : int.tryParse(json['excluido']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'tipo': tipo,
      'cpfCnpj': cpfCnpj,
      'email': email,
      'telefone': telefone,
      'cep': cep,
      'endereco': endereco,
      'bairro': bairro,
      'cidade': cidade,
      'uf': uf,
      'ultimaAlteracao': ultimaAlteracao?.toIso8601String(),
      'excluido': excluido,
    };
  }
}

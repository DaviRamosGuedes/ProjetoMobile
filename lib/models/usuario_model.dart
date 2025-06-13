class UsuarioModel {
  int? id;
  String nome;
  String senha;
  DateTime? ultimaAlteracao;
  int excluido;

  UsuarioModel({
    this.id,
    required this.nome,
    required this.senha,
    this.ultimaAlteracao,
    this.excluido = 0,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      id:
          json['id'] is int
              ? json['id']
              : int.tryParse(json['id'].toString()), // ✅ protege contra string
      nome: json['nome'] ?? '',
      senha: json['senha'] ?? '',
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
      'senha': senha,
      'ultimaAlteracao': ultimaAlteracao?.toIso8601String(),
      'excluido': excluido,
    };
  }
}

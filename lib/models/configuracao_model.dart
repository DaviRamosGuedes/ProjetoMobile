class ConfiguracaoModel {
  String servidorUrl;

  ConfiguracaoModel({required this.servidorUrl});

  factory ConfiguracaoModel.fromJson(Map<String, dynamic> json) {
    return ConfiguracaoModel(servidorUrl: json['servidorUrl']);
  }

  Map<String, dynamic> toJson() {
    return {'servidorUrl': servidorUrl};
  }
}

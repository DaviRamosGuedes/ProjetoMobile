import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const _defaultTimeout = Duration(seconds: 10);
  final String baseUrl;

  ApiService(this.baseUrl);

  /// GET /entidade
  Future<List<dynamic>> fetchList(String endpoint) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/$endpoint'))
          .timeout(_defaultTimeout);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        // Teste.jar retorna: { "dados": [...] }
        if (body is Map && body.containsKey('dados')) {
          final dados = body['dados'];
          if (dados is List) return dados;
        }

        throw Exception(
          'Formato de resposta inválido do Teste.jar para $endpoint',
        );
      } else {
        throw Exception('Erro HTTP ${response.statusCode} em $endpoint');
      }
    } catch (e) {
      throw Exception('Falha na requisição GET $endpoint: ${e.toString()}');
    }
  }

  /// GET /entidade/id
  Future<Map<String, dynamic>> fetchById(String endpoint, int id) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/$endpoint/$id'))
          .timeout(_defaultTimeout);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Erro HTTP ${response.statusCode} em $endpoint/$id');
      }
    } catch (e) {
      throw Exception('Falha ao buscar $endpoint/$id: ${e.toString()}');
    }
  }

  /// POST com lista de objetos
  Future<bool> postList(
    String endpoint,
    List<Map<String, dynamic>> dados,
  ) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/$endpoint'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'dados': dados}), // ✅ compatível com Teste.jar
          )
          .timeout(_defaultTimeout);

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Falha no POST (lista) $endpoint: ${e.toString()}');
    }
  }

  /// DELETE /entidade/id
  Future<bool> deleteById(String endpoint, int id) async {
    try {
      final response = await http
          .delete(Uri.parse('$baseUrl/$endpoint/$id'))
          .timeout(_defaultTimeout);

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Falha no DELETE $endpoint/$id: ${e.toString()}');
    }
  }
}

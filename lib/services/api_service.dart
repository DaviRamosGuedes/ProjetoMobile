import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<List<dynamic>> fetchList(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      if (body is List) return body; // Ex: json-server
      if (body is Map && body.containsKey('dados'))
        return body['dados']; // Ex: servidor do professor

      throw Exception('Formato de resposta inválido para $endpoint');
    } else {
      throw Exception('Erro ${response.statusCode} em $endpoint');
    }
  }

  Future<Map<String, dynamic>> fetchById(String endpoint, int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint/$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao buscar $endpoint/$id');
    }
  }

  Future<bool> postList(
    String endpoint,
    List<Map<String, dynamic>> dados,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'dados': dados}),
    );
    return response.statusCode == 200;
  }

  Future<bool> deleteById(String endpoint, int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$endpoint/$id'));
    return response.statusCode == 200;
  }
}

// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  static const _defaultTimeout = Duration(seconds: 15);

  ApiService(this.baseUrl); // Mantido como posicional para compatibilidade

  // Versão antiga (para compatibilidade)
  Future<List<dynamic>> fetchList(String endpoint) async {
    return fetchAll(endpoint);
  }

  Future<bool> postList(
    String endpoint,
    List<Map<String, dynamic>> data,
  ) async {
    await postAll(endpoint, data);
    return true;
  }

  Future<bool> deleteById(String endpoint, int id) async {
    await deleteOne(endpoint, id);
    return true;
  }

  // Versão nova (recomendada)
  Future<List<dynamic>> fetchAll(String endpoint) async {
    final response = await _makeRequest(
      () => http.get(Uri.parse('$baseUrl/$endpoint')),
      operation: 'FETCH_ALL $endpoint',
    );
    final body = jsonDecode(response.body);
    return body['dados'] as List;
  }

  Future<void> postAll(
    String endpoint,
    List<Map<String, dynamic>> items,
  ) async {
    await _makeRequest(
      () => http.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'dados': items}),
      ),
      operation: 'POST_ALL $endpoint',
    );
  }

  Future<void> deleteOne(String endpoint, int id) async {
    await _makeRequest(
      () => http.delete(Uri.parse('$baseUrl/$endpoint/$id')),
      operation: 'DELETE $endpoint/$id',
    );
  }

  Future<http.Response> _makeRequest(
    Future<http.Response> Function() request, {
    required String operation,
  }) async {
    try {
      final response = await request().timeout(_defaultTimeout);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else {
        throw Exception('HTTP ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Falha em $operation: ${e.toString()}');
    }
  }
}

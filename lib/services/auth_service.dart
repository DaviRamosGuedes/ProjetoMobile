import '../repositories/usuario_repository.dart';
import '../models/usuario_model.dart';

class AuthService {
  final UsuarioRepository _repo = UsuarioRepository();

  Future<UsuarioModel?> login(String nome, String senha) async {
    final usuarios = await _repo.getAll();
    try {
      return usuarios.firstWhere((u) => u.nome == nome && u.senha == senha);
    } catch (_) {
      return null;
    }
  }
}

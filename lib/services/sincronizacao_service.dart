import '../repositories/cliente_repository.dart';
import '../repositories/produto_repository.dart';
import '../repositories/usuario_repository.dart';
import '../repositories/pedido_repository.dart';
import '../models/cliente_model.dart';
import '../models/produto_model.dart';
import '../models/usuario_model.dart';
import '../models/pedido_model.dart';
import 'api_service.dart';

class SincronizacaoService {
  final ApiService api;

  SincronizacaoService(this.api);

  // ==== GET ====

  Future<void> sincronizarUsuarios(UsuarioRepository repo) async {
    try {
      final dados = await api.fetchAll('usuarios'); // Alterado para fetchAll
      for (var json in dados) {
        final usuario = UsuarioModel.fromJson(json);
        await repo.insert(usuario);
      }
    } catch (e) {
      print('Erro ao sincronizar usuários: $e');
      rethrow; // Propaga o erro para ser tratado na UI
    }
  }

  Future<void> sincronizarClientes(ClienteRepository repo) async {
    try {
      final dados = await api.fetchAll('clientes'); // Alterado para fetchAll
      for (var json in dados) {
        final cliente = ClienteModel.fromJson(json);
        await repo.insert(cliente);
      }
    } catch (e) {
      print('Erro ao sincronizar clientes: $e');
      rethrow;
    }
  }

  Future<void> sincronizarProdutos(ProdutoRepository repo) async {
    try {
      final dados = await api.fetchAll('produtos'); // Alterado para fetchAll
      for (var json in dados) {
        final produto = ProdutoModel.fromJson(json);
        await repo.insert(produto);
      }
    } catch (e) {
      print('Erro ao sincronizar produtos: $e');
      rethrow;
    }
  }

  // ==== POST ====

  Future<void> enviarUsuarios(List<UsuarioModel> usuarios) async {
    try {
      await api.postAll(
        // Alterado para postAll
        'usuarios',
        usuarios.map((u) => u.toJson()).toList(),
      );
    } catch (e) {
      print('Erro ao enviar usuários: $e');
      rethrow;
    }
  }

  Future<void> enviarClientes(List<ClienteModel> clientes) async {
    try {
      await api.postAll(
        // Alterado para postAll
        'clientes',
        clientes.map((c) => c.toJson()).toList(),
      );
    } catch (e) {
      print('Erro ao enviar clientes: $e');
      rethrow;
    }
  }

  Future<void> enviarProdutos(List<ProdutoModel> produtos) async {
    try {
      await api.postAll(
        // Alterado para postAll
        'produtos',
        produtos.map((p) => p.toJson()).toList(),
      );
    } catch (e) {
      print('Erro ao enviar produtos: $e');
      rethrow;
    }
  }

  Future<void> enviarPedidos(List<PedidoModel> pedidos) async {
    try {
      await api.postAll(
        // Alterado para postAll
        'pedidos',
        pedidos.map((p) => p.toJson()).toList(),
      );
    } catch (e) {
      print('Erro ao enviar pedidos: $e');
      rethrow;
    }
  }

  // ==== DELETE ====

  Future<void> excluirRemotamente(String endpoint, int id) async {
    try {
      await api.deleteOne(endpoint, id); // Alterado para deleteOne
    } catch (e) {
      print('Erro ao excluir $endpoint (ID $id): $e');
      rethrow;
    }
  }
}

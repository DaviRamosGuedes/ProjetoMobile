import 'package:flutter/material.dart';
import '../repositories/cliente_repository.dart';
import '../repositories/produto_repository.dart';
import '../repositories/usuario_repository.dart';
import '../repositories/pedido_repository.dart';
import '../services/sincronizacao_service.dart';
import '../services/api_service.dart';
import '../widgets/app_drawer.dart';

class SincronizacaoScreen extends StatefulWidget {
  const SincronizacaoScreen({super.key});

  @override
  State<SincronizacaoScreen> createState() => _SincronizacaoScreenState();
}

class _SincronizacaoScreenState extends State<SincronizacaoScreen> {
  final api = ApiService('http://10.0.2.2:8080');
  late final SincronizacaoService syncService;

  final _usuarioRepo = UsuarioRepository();
  final _clienteRepo = ClienteRepository();
  final _produtoRepo = ProdutoRepository();
  final _pedidoRepo = PedidoRepository();

  String _status = 'Aguardando...';
  Map<String, List<String>> erros = {};

  @override
  void initState() {
    super.initState();
    syncService = SincronizacaoService(api);
  }

  Future<void> _sincronizar() async {
    setState(() {
      _status = 'Sincronizando...';
      erros.clear();
    });

    try {
      await _tentar(
        () => syncService.sincronizarUsuarios(_usuarioRepo),
        'Usuários',
      );
      await _tentar(
        () => syncService.sincronizarClientes(_clienteRepo),
        'Clientes',
      );
      await _tentar(
        () => syncService.sincronizarProdutos(_produtoRepo),
        'Produtos',
      );
      // pedidos sincronizados apenas no envio
      setState(
        () =>
            _status =
                erros.isEmpty
                    ? 'Sincronização concluída com sucesso.'
                    : 'Concluído com erros.',
      );
    } catch (e) {
      setState(() => _status = 'Erro geral: ${e.toString()}');
    }
  }

  Future<void> _tentar(Future<void> Function() func, String entidade) async {
    try {
      await func();
    } catch (e) {
      erros.putIfAbsent(entidade, () => []).add(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sincronização')),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _sincronizar,
              child: const Text('Sincronizar Dados'),
            ),
            const SizedBox(height: 16),
            Text(_status, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            if (erros.isNotEmpty)
              Expanded(
                child: ListView(
                  children:
                      erros.entries.expand((entry) {
                        return entry.value.map(
                          (msg) => ListTile(
                            leading: const Icon(Icons.error, color: Colors.red),
                            title: Text(entry.key),
                            subtitle: Text(msg),
                          ),
                        );
                      }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

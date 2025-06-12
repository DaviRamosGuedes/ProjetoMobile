import 'package:flutter/material.dart';
import '../screens/cadastro_cliente_screen.dart';
import '../screens/cadastro_produto_screen.dart';
import '../screens/pedido_screen.dart';
import '../screens/sincronizacao_screen.dart';
import '../screens/configuracao_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(child: Text('Menu')),
          ListTile(
            title: const Text('Clientes'),
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CadastroClienteScreen(),
                  ),
                ),
          ),
          ListTile(
            title: const Text('Produtos'),
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CadastroProdutoScreen(),
                  ),
                ),
          ),
          ListTile(
            title: const Text('Pedidos'),
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PedidoScreen()),
                ),
          ),
          ListTile(
            title: const Text('Sincronizar'),
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SincronizacaoScreen(),
                  ),
                ),
          ),
          ListTile(
            title: const Text('Configurações'),
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ConfiguracaoScreen()),
                ),
          ),
        ],
      ),
    );
  }
}

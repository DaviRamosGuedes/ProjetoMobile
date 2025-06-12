import 'package:flutter/material.dart';
import '../repositories/configuracao_repository.dart';
import '../models/configuracao_model.dart';
import '../widgets/app_drawer.dart';

class ConfiguracaoScreen extends StatefulWidget {
  const ConfiguracaoScreen({super.key});

  @override
  State<ConfiguracaoScreen> createState() => _ConfiguracaoScreenState();
}

class _ConfiguracaoScreenState extends State<ConfiguracaoScreen> {
  final _controller = TextEditingController();
  final _repo = ConfiguracaoRepository();

  void _salvar() async {
    final config = ConfiguracaoModel(servidorUrl: _controller.text);
    await _repo.salvarConfiguracao(config);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Configuração salva')));
  }

  void _carregar() async {
    final config = await _repo.getConfiguracao();
    if (config != null) {
      _controller.text = config.servidorUrl;
    }
  }

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'URL do Servidor'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _salvar, child: const Text('Salvar')),
          ],
        ),
      ),
    );
  }
}

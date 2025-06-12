import 'package:flutter/material.dart';
import '../models/produto_model.dart';
import '../repositories/produto_repository.dart';
import '../utils/constants.dart';
import '../utils/validators.dart';
import '../widgets/app_drawer.dart';

class CadastroProdutoScreen extends StatefulWidget {
  const CadastroProdutoScreen({super.key});

  @override
  State<CadastroProdutoScreen> createState() => _CadastroProdutoScreenState();
}

class _CadastroProdutoScreenState extends State<CadastroProdutoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _repo = ProdutoRepository();

  final _nome = TextEditingController();
  String _unidade = Constants.unidades.first;
  final _qtdEstoque = TextEditingController();
  final _precoVenda = TextEditingController();
  final _status = ValueNotifier<bool>(true);
  final _custo = TextEditingController();
  final _codigoBarra = TextEditingController();

  void _salvar() async {
    if (_formKey.currentState!.validate()) {
      final produto = ProdutoModel(
        nome: _nome.text,
        unidade: _unidade,
        qtdEstoque: double.parse(_qtdEstoque.text),
        precoVenda: double.parse(_precoVenda.text),
        status: _status.value ? 0 : 1,
        custo: double.tryParse(_custo.text),
        codigoBarra: _codigoBarra.text,
      );
      await _repo.insert(produto);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Produto salvo')));
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Produto')),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nome,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: Validators.campoObrigatorio,
              ),
              DropdownButtonFormField<String>(
                value: _unidade,
                items:
                    Constants.unidades
                        .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                        .toList(),
                onChanged: (val) => setState(() => _unidade = val!),
                decoration: const InputDecoration(labelText: 'Unidade'),
              ),
              TextFormField(
                controller: _qtdEstoque,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Estoque'),
                validator: Validators.campoObrigatorio,
              ),
              TextFormField(
                controller: _precoVenda,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Preço de Venda'),
                validator: Validators.campoObrigatorio,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _status,
                builder:
                    (_, ativo, __) => SwitchListTile(
                      title: const Text('Ativo'),
                      value: ativo,
                      onChanged: (val) => _status.value = val,
                    ),
              ),
              TextFormField(
                controller: _custo,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Custo'),
              ),
              TextFormField(
                controller: _codigoBarra,
                decoration: const InputDecoration(labelText: 'Código de Barra'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _salvar, child: const Text('Salvar')),
            ],
          ),
        ),
      ),
    );
  }
}

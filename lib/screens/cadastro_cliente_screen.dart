import 'package:flutter/material.dart';
import '../models/cliente_model.dart';
import '../repositories/cliente_repository.dart';
import '../services/viacep_service.dart';
import '../utils/validators.dart';
import '../widgets/app_drawer.dart';

class CadastroClienteScreen extends StatefulWidget {
  const CadastroClienteScreen({super.key});

  @override
  State<CadastroClienteScreen> createState() => _CadastroClienteScreenState();
}

class _CadastroClienteScreenState extends State<CadastroClienteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _repo = ClienteRepository();

  final _nome = TextEditingController();
  final _tipo = TextEditingController();
  final _cpfCnpj = TextEditingController();
  final _email = TextEditingController();
  final _telefone = TextEditingController();
  final _cep = TextEditingController();
  final _endereco = TextEditingController();
  final _bairro = TextEditingController();
  final _cidade = TextEditingController();
  final _uf = TextEditingController();

  void _buscarCep() async {
    final data = await ViaCepService.buscarCep(_cep.text);
    if (data != null) {
      _endereco.text = data['logradouro'] ?? '';
      _bairro.text = data['bairro'] ?? '';
      _cidade.text = data['localidade'] ?? '';
      _uf.text = data['uf'] ?? '';
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('CEP não encontrado')));
    }
  }

  void _salvar() async {
    if (_formKey.currentState!.validate()) {
      final cliente = ClienteModel(
        nome: _nome.text,
        tipo: _tipo.text,
        cpfCnpj: _cpfCnpj.text,
        email: _email.text,
        telefone: _telefone.text,
        cep: _cep.text,
        endereco: _endereco.text,
        bairro: _bairro.text,
        cidade: _cidade.text,
        uf: _uf.text,
      );
      await _repo.insert(cliente);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Cliente salvo')));
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Cliente')),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nome,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: Validators.campoObrigatorio,
              ),
              TextFormField(
                controller: _tipo,
                decoration: const InputDecoration(labelText: 'Tipo (F/J)'),
                validator: Validators.campoObrigatorio,
              ),
              TextFormField(
                controller: _cpfCnpj,
                decoration: const InputDecoration(labelText: 'CPF/CNPJ'),
                validator: Validators.cpfCnpj,
              ),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _telefone,
                decoration: const InputDecoration(labelText: 'Telefone'),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _cep,
                      decoration: const InputDecoration(labelText: 'CEP'),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _buscarCep,
                  ),
                ],
              ),
              TextFormField(
                controller: _endereco,
                decoration: const InputDecoration(labelText: 'Endereço'),
              ),
              TextFormField(
                controller: _bairro,
                decoration: const InputDecoration(labelText: 'Bairro'),
              ),
              TextFormField(
                controller: _cidade,
                decoration: const InputDecoration(labelText: 'Cidade'),
              ),
              TextFormField(
                controller: _uf,
                decoration: const InputDecoration(labelText: 'UF'),
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

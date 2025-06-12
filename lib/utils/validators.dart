class Validators {
  static String? campoObrigatorio(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  static String? cpfCnpj(String? value) {
    if (value == null || value.trim().isEmpty) return 'Informe o CPF/CNPJ';
    if (value.length < 11) return 'CPF/CNPJ inválido';
    return null;
  }

  static String? email(String? value) {
    if (value != null && value.isNotEmpty && !value.contains('@')) {
      return 'Email inválido';
    }
    return null;
  }
}

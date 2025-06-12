import 'package:flutter/material.dart';

Future<bool?> mostrarConfirmacaoDialog(BuildContext context, String mensagem) {
  return showDialog<bool>(
    context: context,
    builder:
        (ctx) => AlertDialog(
          title: const Text('Confirmação'),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Não'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Sim'),
            ),
          ],
        ),
  );
}

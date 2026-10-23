import 'package:flutter/material.dart';

import '../../../app/tema/cores_do_app.dart';

// O cartão de identificação do topo da tela de perfil.
class CartaoDoUsuario extends StatelessWidget {
  const CartaoDoUsuario({super.key, required this.nome, required this.email});

  final String nome;
  final String email;

  @override
  Widget build(BuildContext context) {
    final textos = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const .all(20),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 32,
              backgroundColor: CoresDoApp.azul,
              child: Icon(Icons.person, color: Colors.white, size: 36),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    nome,
                    style: textos.titleLarge?.copyWith(fontWeight: .w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: textos.bodyMedium?.copyWith(
                      color: CoresDoApp.textoSecundario,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

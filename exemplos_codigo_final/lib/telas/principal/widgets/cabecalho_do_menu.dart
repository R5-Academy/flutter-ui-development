import 'package:flutter/material.dart';

import '../../../app/tema/cores_do_app.dart';

// O cabeçalho do menu lateral: quem está usando o app.
class CabecalhoDoMenu extends StatelessWidget {
  const CabecalhoDoMenu({super.key, required this.nome, required this.email});

  final String nome;
  final String email;

  @override
  Widget build(BuildContext context) {
    final TextTheme textos = Theme.of(context).textTheme;

    // O DrawerHeader já reserva a faixa da barra de status por cima do padding.
    return DrawerHeader(
      margin: .zero,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundColor: CoresDoApp.azul,
            child: Icon(Icons.person, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .start,
              children: [
                Text(
                  nome,
                  style: textos.titleMedium?.copyWith(fontWeight: .w600),
                ),
                const SizedBox(height: 2),
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
    );
  }
}

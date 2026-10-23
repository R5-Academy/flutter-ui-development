import 'package:flutter/material.dart';

import '../app/tema/cores_do_app.dart';

// Título + descrição no começo de uma tela. Compartilhado porque mais de uma
// tela precisa exatamente do mesmo par.
class TituloDaSecao extends StatelessWidget {
  const TituloDaSecao({
    super.key,
    required this.titulo,
    required this.descricao,
  });

  final String titulo;
  final String descricao;

  @override
  Widget build(BuildContext context) {
    final textos = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(titulo, style: textos.headlineSmall?.copyWith(fontWeight: .w700)),
        const SizedBox(height: 8),
        Text(
          descricao,
          style: textos.bodyLarge?.copyWith(color: CoresDoApp.textoSecundario),
        ),
      ],
    );
  }
}

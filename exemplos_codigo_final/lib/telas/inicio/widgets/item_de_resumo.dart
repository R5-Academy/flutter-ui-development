import 'package:flutter/material.dart';

import '../../../app/tema/cores_do_app.dart';
import '../../../modelos/dado_de_resumo.dart';

// Uma coluna do painel: o ícone dentro do círculo, o número e o rótulo.
class ItemDeResumo extends StatelessWidget {
  const ItemDeResumo({super.key, required this.dado});

  final DadoDeResumo dado;

  @override
  Widget build(BuildContext context) {
    final TextTheme textos = Theme.of(context).textTheme;

    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: dado.cor.withValues(alpha: 0.14),
          child: Icon(dado.icone, color: dado.cor),
        ),
        const SizedBox(height: 10),
        Text(
          dado.valor,
          style: textos.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 2),
        Text(
          dado.rotulo,
          style: textos.bodySmall?.copyWith(color: CoresDoApp.textoSecundario),
        ),
      ],
    );
  }
}

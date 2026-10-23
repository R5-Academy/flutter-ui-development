import 'package:flutter/material.dart';

import '../../../app/tema/cores_do_app.dart';

// A tarja "Pendente" / "Concluída" embaixo de cada tarefa.
class EtiquetaDeSituacao extends StatelessWidget {
  const EtiquetaDeSituacao({super.key, required this.concluida});

  final bool concluida;

  @override
  Widget build(BuildContext context) {
    final cor = concluida ? CoresDoApp.verde : CoresDoApp.azul;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: cor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          concluida ? 'Concluída' : 'Pendente',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: cor,
          ),
        ),
      ),
    );
  }
}

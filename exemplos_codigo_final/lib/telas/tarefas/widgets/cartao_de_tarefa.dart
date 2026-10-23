import 'package:flutter/material.dart';

import '../../../app/tema/cores_do_app.dart';
import '../../../modelos/tarefa.dart';
import 'etiqueta_de_situacao.dart';

// Uma tarefa da lista. O cartão não altera nada: avisa que a caixinha foi
// tocada e quem guarda o estado decide o que fazer.
class CartaoDeTarefa extends StatelessWidget {
  const CartaoDeTarefa({
    super.key,
    required this.tarefa,
    required this.aoAlternar,
  });

  final Tarefa tarefa;
  final VoidCallback aoAlternar;

  @override
  Widget build(BuildContext context) {
    final TextTheme textos = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: tarefa.concluida,
              onChanged: (bool? _) => aoAlternar(),
              activeColor: CoresDoApp.verde,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tarefa.titulo,
                    style: textos.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    tarefa.descricao,
                    style: textos.bodyMedium?.copyWith(
                      color: CoresDoApp.textoSecundario,
                    ),
                  ),
                  const SizedBox(height: 10),
                  EtiquetaDeSituacao(concluida: tarefa.concluida),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

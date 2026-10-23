import 'package:flutter/material.dart';

import '../../modelos/tarefa.dart';
import '../../widgets/titulo_da_secao.dart';
import 'widgets/cartao_de_tarefa.dart';

// * A tela do destino Tarefas. É a única com estado próprio — e é justamente
// * ela que prova o IndexedStack: marque uma tarefa, vá para Perfil e volte.
// * A marcação continua lá.
class TelaTarefas extends StatefulWidget {
  const TelaTarefas({super.key});

  @override
  State<TelaTarefas> createState() => _TelaTarefasState();
}

class _TelaTarefasState extends State<TelaTarefas> {
  final _tarefas = <Tarefa>[
    const Tarefa(
      titulo: 'Estudar Flutter',
      descricao: 'Aprender sobre widgets',
    ),
    const Tarefa(
      titulo: 'Fazer Exercício',
      descricao: 'Praticar o layout da aula',
    ),
    const Tarefa(
      titulo: 'Assistir Aula',
      descricao: 'Aula sobre Scaffold',
      concluida: true,
    ),
  ];

  void _alternarTarefa(int indice) {
    setState(() => _tarefas[indice] = _tarefas[indice].alternarConclusao());
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const .all(20),
      children: [
        const TituloDaSecao(
          titulo: 'Minhas Tarefas',
          descricao: 'Confira suas tarefas pendentes e concluídas.',
        ),
        const SizedBox(height: 20),
        for (var indice = 0; indice < _tarefas.length; indice++)
          Padding(
            padding: const .only(bottom: 12),
            child: CartaoDeTarefa(
              tarefa: _tarefas[indice],
              aoAlternar: () => _alternarTarefa(indice),
            ),
          ),
      ],
    );
  }
}

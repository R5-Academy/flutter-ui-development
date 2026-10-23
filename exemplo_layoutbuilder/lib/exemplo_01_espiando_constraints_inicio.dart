// exemplo_01_espiando_constraints_inicio.dart
// Ponto de partida: um LayoutBuilder ocupando a largura toda do corpo.
//
// * O builder é uma função (BuildContext context, BoxConstraints constraints)
// * => Widget. O `constraints` é LITERALMENTE a restrição que veio de cima:
// * quanto de largura e altura este espaço tem disponível.
// * O LayoutBuilder não desenha nada sozinho — ele só chama o builder passando
// * as constraints do pai. Nós decidimos o que devolver.
//
// Leia os números. Depois a pergunta é: eles são fixos, ou dependem de onde
// este LayoutBuilder está?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaEspiandoConstraints()));

class TelaEspiandoConstraints extends StatelessWidget {
  const TelaEspiandoConstraints({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Espiando as constraints do pai')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          // ! Repare no `start`. Com `CrossAxisAlignment.stretch` a Column manda
          // ! largura TIGHT para os filhos, e aí qualquer caixa de largura fixa
          // ! que a gente puser aqui dentro seria ignorada (a constraint do pai
          // ! sempre ganha). Com `start`, a largura desce solta (loose).
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Este LayoutBuilder ocupa a largura toda do corpo:'),
            const SizedBox(height: 8),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return _PainelDeConstraints(constraints: constraints);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Lê os campos do BoxConstraints e mostra na tela, sem enfeite. Serve para ver
// com os próprios olhos o que "a constraint do pai" significa.
class _PainelDeConstraints extends StatelessWidget {
  const _PainelDeConstraints({required this.constraints});

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Ocupa toda a largura que o pai ofereceu, para a caixa desenhada bater
      // com o número que ela mostra.
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.indigo.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.indigo.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // maxWidth é o número que mais vamos usar: "quanta largura eu tenho".
          Text('maxWidth: ${constraints.maxWidth.toStringAsFixed(1)}'),
          // ? maxHeight aparece como "Infinity": a Column não dá teto de altura
          // ? aos filhos. Guarde esse número — ele volta no último exemplo.
          Text('maxHeight: ${constraints.maxHeight.toStringAsFixed(1)}'),
          Text('minWidth: ${constraints.minWidth.toStringAsFixed(1)}'),
          Text('minHeight: ${constraints.minHeight.toStringAsFixed(1)}'),
          const Divider(),
          // Os mesmos getters de tight/loose/bounded da aula de Constraints.
          Text('isTight: ${constraints.isTight}'),
          Text('hasBoundedWidth: ${constraints.hasBoundedWidth}'),
          Text('hasBoundedHeight: ${constraints.hasBoundedHeight}'),
        ],
      ),
    );
  }
}

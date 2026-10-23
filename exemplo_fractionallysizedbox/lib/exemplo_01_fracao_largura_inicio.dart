// exemplo_01_fracao_largura_inicio.dart
// Ponto de partida: um painel que ocupa a tela inteira.
//
// Queremos que ele use metade da largura — mas metade em pixels de quê? Num
// celular pequeno 180 é metade; num tablet, não é nem um terço. Cravar um
// número não resolve.
//
// A saída é pedir um tamanho RELATIVO.
//
// * Sobre o SizedBox.expand: o body do Scaffold entrega constraints LOOSE
// * (0 <= w <= largura, 0 <= h <= altura). O expand transforma isso em TIGHT — a
// * caixa passa a ser obrigada a ocupar a tela inteira. É essa largura que vamos
// * fracionar no próximo passo, e é ela que precisa estar bem definida para a
// * conta da fração ter um número em cima do qual incidir.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoFracaoLargura()));

class DemoFracaoLargura extends StatelessWidget {
  const DemoFracaoLargura({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox.expand(
        child: ColoredBox(
          color: Colors.indigo,
          child: Center(
            child: Text(
              'largura inteira',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}

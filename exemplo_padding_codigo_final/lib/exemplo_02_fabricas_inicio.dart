// exemplo_02_fabricas_inicio.dart
// Ponto de partida: o EdgeInsets.all do bloco anterior, agora num "chip".
//
// O all serve para o caso mais comum — mesmo valor nos quatro lados. Mas este
// chip queria ser uma pílula: bem largo nas laterais, baixinho em cima e
// embaixo. Com o `all` não dá.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Demo()));

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // * Center, Column e SizedBox ainda não foram ensinados (aulas 03/04/05
      // * desta seção e a de Layouts Flexíveis). Aqui eles só empilham os chips
      // * para caberem todos na mesma tela — o foco é o `padding` de cada um.
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // all: um valor para os quatro lados. O atalho do caso comum.
            _Chip(rotulo: 'all(16)', padding: EdgeInsets.all(16)),
            SizedBox(height: 16),

            // symmetric: um valor para o eixo horizontal (esquerda + direita) e
            // outro para o vertical (cima + baixo). Dá a forma de pílula.
            _Chip(
              rotulo: 'symmetric(h: 32, v: 8)',
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            ),
            SizedBox(height: 16),

            // only: só os lados que você citar; os demais ficam 0.
            // Bom para afastar de UM lado.
            _Chip(
              rotulo: 'only(left: 40, top: 8)',
              padding: EdgeInsets.only(left: 40, top: 8),
            ),
            SizedBox(height: 16),

            // fromLTRB: Left, Top, Right, Bottom na ordem, cada lado explícito.
            _Chip(
              rotulo: 'fromLTRB(16, 8, 16, 24)',
              padding: EdgeInsets.fromLTRB(16, 8, 16, 24),
            ),
            SizedBox(height: 16),

            // zero: nada em lado nenhum. Útil como valor neutro.
            _Chip(rotulo: 'zero', padding: EdgeInsets.zero),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.rotulo, required this.padding});

  final String rotulo;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFB2DFDB),
      child: Padding(padding: padding, child: Text(rotulo)),
    );
  }
}

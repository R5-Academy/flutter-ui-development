// exemplo_04_cross_stretch_inicio.dart
// Ponto de partida: um card, um bloco e um botão numa Column, com o
// crossAxisAlignment padrão (center).
//
// ! Cada um ficou com a largura do próprio conteúdo, centralizado. Num
// ! formulário ou numa tela de detalhe, o esperado é que card e botão ocupem a
// ! largura toda — é o visual que todo app tem.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: CrossStretch()));

class CrossStretch extends StatelessWidget {
  const CrossStretch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Column: stretch na largura')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            Card(
              color: Colors.indigo.withValues(alpha: 0.1),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Card do tamanho do conteúdo'),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: 100,
              height: 60,
              color: Colors.teal,
              alignment: Alignment.center,
              child: const Text(
                'width: 100',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () {},
              child: const Text('Botão do tamanho do texto'),
            ),
          ],
        ),
      ),
    );
  }
}

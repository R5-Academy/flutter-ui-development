// exemplo_03_fit_inicio.dart
// Ponto de partida: o `fit` no padrão — StackFit.loose.
//
// * Com loose, o Stack passa constraints FROUXAS aos filhos não posicionados.
// * Cada um fica com o seu tamanho natural: o card teal encolheu até caber só o
// * texto (uma tarja pequena no meio), e sobra o cinza do palco em volta.
//
// E se você quisesse que esse card preenchesse o Stack inteiro?

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: StackFitDemo()));

class StackFitDemo extends StatelessWidget {
  const StackFitDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StackFit: loose')),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          color: Colors.blueGrey.withValues(alpha: 0.15),
          child: Stack(
            // StackFit.loose é o padrão — nem precisa escrever.
            fit: .passthrough,
            alignment: Alignment.center,
            children: [
              // Este card não tem width/height próprios: é ele quem reage ao fit.
              Container(
                color: Colors.teal.withValues(alpha: 0.35),
                padding: const EdgeInsets.all(12),
                child: const Text('sem tamanho fixo'),
              ),
              // Uma marca fixa por cima, só para referência do canto.
              const Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: ColoredBox(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

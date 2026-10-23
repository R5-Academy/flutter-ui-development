// exemplo_01_maxwidth_inicio.dart
// Ponto de partida: um card de texto sem limite nenhum de largura.
//
// Rode numa janela larga (Chrome ou desktop) e alargue: o parágrafo estica a
// tela inteira. Linhas longas demais cansam a leitura — este é o problema que
// o ConstrainedBox resolve.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaLeitura()));

class TelaLeitura extends StatelessWidget {
  const TelaLeitura({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('maxWidth para legibilidade')),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 290),
          child: LayoutBuilder(
            builder: (_, constrains) {
              debugPrint(constrains.minWidth.toString());
              debugPrint(constrains.maxWidth.toString());
              return _CardDeLeitura();
            },
          ),
        ),
      ),
    );
  }
}

class _CardDeLeitura extends StatelessWidget {
  const _CardDeLeitura();

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          'Linhas de texto muito longas cansam a leitura. Sem um teto de '
          'largura, este parágrafo estica a tela inteira num monitor grande. '
          'Com maxWidth 600, o card cresce até 600 e para — em tela estreita, '
          'ele continua usando toda a largura disponível.',
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ),
    );
  }
}

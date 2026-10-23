// exemplo_04_01_factor_inicio.dart
// Ponto de partida: a segunda metade do recorte. Até agora a pergunta era ONDE o
// filho fica. Agora é: QUE TAMANHO o próprio Align ocupa?
//
// O ColoredBox amarelo envolve o Align, então o amarelo mostra exatamente o
// tamanho dele.
//
// * SEM factor e com pai bounded (o body), o Align fica "o maior possível" e
// * preenche a tela toda — só para encostar uma caixinha de 80 no canto.
//
// Medido numa tela de 400x800: o amarelo mede 400x744 (o body inteiro, já
// descontada a AppBar) e o roxo de 80x80 fica em (320, 720), o canto de baixo.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DemoFator()));

class DemoFator extends StatelessWidget {
  const DemoFator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('widthFactor / heightFactor')),
      body: Center(
        child: const ColoredBox(
          color: Colors.amber,
          child: Align(
            alignment: Alignment.bottomRight,
            widthFactor: 3,

            /// W = 160 h = 744
            heightFactor: 2,
            child: _Filho(),
          ),
        ),
      ),
    );
  }
}

class _Filho extends StatelessWidget {
  const _Filho();

  @override
  Widget build(BuildContext context) {
    return Container(width: 80, height: 80, color: Colors.deepPurple);
  }
}

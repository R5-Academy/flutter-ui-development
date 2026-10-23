// exemplo_05_main_axis_size_inicio.dart
// Ponto de partida: a Column com o mainAxisSize padrão (max).
//
// * O fundo amarelo é a Column. Repare que ele preenche a coluna INTEIRA, de
// * cima a baixo, sobrando espaço em volta dos três blocos.
//
// Até aqui a Column sempre ocupou tudo por padrão e ninguém reparou. Num Card
// ou num balão de diálogo, esse estufamento é justamente o problema.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: MainAxisSizeDemo()));

class MainAxisSizeDemo extends StatelessWidget {
  const MainAxisSizeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('mainAxisSize: max')),
      body: const Center(
        child: ColoredBox(
          color: Colors.amber,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Bloco(cor: Colors.red, rotulo: '1'),
              _Bloco(cor: Colors.green, rotulo: '2'),
              _Bloco(cor: Colors.blue, rotulo: '3'),
            ],
          ),
        ),
      ),
    );
  }
}

class _Bloco extends StatelessWidget {
  const _Bloco({required this.cor, required this.rotulo});

  final Color cor;
  final String rotulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 70,
      margin: const EdgeInsets.all(6),
      color: cor,
      alignment: Alignment.center,
      child: Text(
        rotulo,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

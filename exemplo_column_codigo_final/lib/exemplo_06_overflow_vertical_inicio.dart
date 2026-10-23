// exemplo_06_overflow_vertical_inicio.dart
// Ponto de partida: quatro itens numa Column. Tudo cabe, tudo certo.
//
// Agora imagine que a lista veio do backend e tem dez. Troque o 4 por 10 e rode
// de novo.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: OverflowVertical()));

class OverflowVertical extends StatelessWidget {
  const OverflowVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Column: overflow vertical')),
      body: Column(children: [for (var i = 1; i <= 10; i++) _Item(numero: i)]),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.numero});

  final int numero;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      color: Colors.blue.withValues(alpha: 0.15 * (numero % 3 + 1)),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text('Item $numero'),
    );
  }
}

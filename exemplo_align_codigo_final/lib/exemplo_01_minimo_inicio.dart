// exemplo_01_minimo_inicio.dart
// Ponto de partida: uma caixinha solta como body, sem ninguém posicionando.
//
// Ela encostou no topo-esquerda. É sempre ali que um filho único para, quando
// nada manda o contrário.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DemoAlignMinimo()));

class DemoAlignMinimo extends StatelessWidget {
  const DemoAlignMinimo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Align: o mínimo')),
      body: Align(
        alignment: .bottomRight,
        child: Container(width: 120, height: 120, color: Colors.deepPurple),
      ),
    );
  }
}

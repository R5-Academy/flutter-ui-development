// exemplo_03_vs_sizedbox_inicio.dart
// Ponto de partida: uma etiqueta com largura TRAVADA em 260, via SizedBox.
//
// ! O texto "Etiqueta" é curto, mas o card continua com 260 de largura e sobra
// ! um monte de espaço vazio dentro dele. SizedBox é tamanho EXATO (tight):
// ! ele não encolhe para o conteúdo.
//
// E se quiséssemos "no máximo 260, mas encolha se couber menos"?

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaComparacao()));

class TelaComparacao extends StatelessWidget {
  const TelaComparacao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Faixa vs tamanho exato')),
      // body: const Center(child: SizedBox(width: 260, child: _Etiqueta())),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 260),
          child: _Etiqueta(),
        ),
      ),
    );
  }
}

class _Etiqueta extends StatelessWidget {
  const _Etiqueta();

  @override
  Widget build(BuildContext context) {
    return const Card(
      color: Colors.teal,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Etiqueta',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

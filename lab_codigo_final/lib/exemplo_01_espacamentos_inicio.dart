// exemplo_01_espacamentos_inicio.dart
// Uma grade de três colunas, com a altura das células cravada em pixels.
//
// As células estão todas coladas umas nas outras, e a grade encosta na borda
// da tela.
//
// Falta o respiro.

import 'package:flutter/material.dart';

const int kColunas = 3;
const double kAltura = 120.0;

void main() => runApp(const AppDosEspacos());

class AppDosEspacos extends StatelessWidget {
  const AppDosEspacos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Espaçamentos da grade',
      theme: ThemeData(colorSchemeSeed: Colors.brown),
      home: const TelaDosEspacos(),
    );
  }
}

class TelaDosEspacos extends StatelessWidget {
  const TelaDosEspacos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Espaçamentos da grade')),
      body: DecoratedBox(
        // O fundo cinza deixa visível onde há espaço e onde não há.
        decoration: BoxDecoration(color: Colors.grey.shade300),
        child: GridView.builder(
          padding: .all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: kColunas,
            mainAxisExtent: kAltura,
            mainAxisSpacing: 12,
            crossAxisSpacing: 8,
          ),
          itemCount: 60,
          itemBuilder: (context, indice) => _Celula(indice: indice),
        ),
      ),
    );
  }
}

class _Celula extends StatelessWidget {
  const _Celula({required this.indice});

  final int indice;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.primaries[indice % Colors.primaries.length].shade200,
      alignment: Alignment.center,
      child: Text(
        '$indice',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

// exemplo_02_itemextent_inicio.dart
// Quinhentos itens, todos com a mesma altura: 80 pixels.
//
// O ListView não sabe disso. Para ele, cada item pode ter uma altura
// diferente, então ele precisa construir e medir cada um para descobrir.
//
// Role rápido até o fim e repare no esforço.

import 'package:flutter/material.dart';

const int kTotal = 50000;
const double kAltura = 80.0;

void main() => runApp(const AppExtent());

class AppExtent extends StatelessWidget {
  const AppExtent({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'itemExtent',
      theme: ThemeData(colorSchemeSeed: Colors.blueGrey),
      home: const TelaExtent(),
    );
  }
}

class TelaExtent extends StatelessWidget {
  const TelaExtent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('500 itens de 80px')),
      body: ListView.builder(
        itemCount: kTotal,
        itemExtent: kAltura,
        itemBuilder: (context, index) => _Item(indice: index),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.indice});

  final int indice;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kAltura,
      child: ListTile(
        leading: CircleAvatar(child: Text('$indice')),
        title: Text('Item $indice'),
        subtitle: const Text('altura fixa de 80'),
      ),
    );
  }
}

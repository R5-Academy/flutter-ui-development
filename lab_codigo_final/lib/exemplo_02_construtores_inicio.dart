// exemplo_02_construtores_inicio.dart
// Um cardápio de quatro itens, digitados na mão, num ListView(children:).
//
// Para quatro itens fixos isso está perfeito: não existe builder que melhore.
//
// A pergunta que abre o próximo passo: e quando a lista não tem quatro itens,
// e sim mil, vindos de uma API?

import 'package:flutter/material.dart';

void main() => runApp(const AppConstrutores());

class AppConstrutores extends StatelessWidget {
  const AppConstrutores({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Os construtores do ListView',
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: const TelaConstrutores(),
    );
  }
}

class TelaConstrutores extends StatelessWidget {
  const TelaConstrutores({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Os construtores do ListView')),
      body: Column(
        children: [
          Expanded(child: _SecaoChildren()),
          Divider(height: 1),
          Expanded(child: _SecaoBuilder()),
          Divider(height: 1),
          Expanded(child: _SecaoSeparated()),
        ],
      ),
    );
  }
}

class _SecaoChildren extends StatelessWidget {
  static const _menu = ['Café', 'Pão de queijo', 'Suco', 'Bolo'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Titulo(texto: 'ListView(children:) - 4 itens fixos'),
        Expanded(
          child: ListView(
            children: [
              for (final item in _menu)
                Card(child: ListTile(title: Text(item))),
            ],
          ),
        ),
      ],
    );
  }
}

class _SecaoBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _Titulo(
          texto: 'ListView.builder - 1000 itens, só os visíveis nascem',
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 1000,
            itemBuilder: (context, index) {
              return ListTile(
                dense: true,
                leading: CircleAvatar(child: Text('$index')),
                title: Text('Item $index'),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SecaoSeparated extends StatelessWidget {
  const _SecaoSeparated();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _Titulo(texto: 'ListView.separed - N itens, N+1 separadores'),
        Expanded(
          child: ListView.separated(
            itemCount: 1000,
            itemBuilder: (context, index) {
              return ListTile(
                dense: true,
                leading: CircleAvatar(child: Text('$index')),
                title: Text('Item $index'),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 1,
                color: Colors.teal.shade200,
                indent: 50,
                endIndent: 50,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Titulo extends StatelessWidget {
  final String texto;

  const _Titulo({required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: .all(8),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Text(
        texto,
        style: TextStyle(fontFamily: 'monospace', fontSize: 11),
      ),
    );
  }
}

// exemplo_02_01_constraint_inicio.dart
// Duas caixas na tela, lado a lado na vertical.
//
// A de cima tem um conteúdo direto no Scaffold.
// A de baixo tem o mesmo conteúdo, mas dentro de um SingleChildScrollView.
//
// Por enquanto as duas mostram só um texto fixo. O que a gente quer descobrir
// é qual constraint de altura cada uma recebe do pai.

import 'package:flutter/material.dart';

void main() => runApp(const AppConstraint());

class AppConstraint extends StatelessWidget {
  const AppConstraint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A constraint que desce',
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const TelaConstraint(),
    );
  }
}

class TelaConstraint extends StatelessWidget {
  const TelaConstraint({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('A constraint que desce')),
      body: Column(
        children: [
          Expanded(
            child: _Cartao(
              titulo: 'Column direto no Scaffold (sem scroll)',
              cor: Colors.green.shade50,
              child: const _Conteudo(),
            ),
          ),
          Expanded(
            child: _Cartao(
              titulo: 'Dentro do SingleChildScrollView',
              cor: Colors.red.shade50,
              child: const SingleChildScrollView(child: _Conteudo()),
            ),
          ),
        ],
      ),
    );
  }
}

class _Conteudo extends StatelessWidget {
  const _Conteudo();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) =>
          _MostrarConstraint(constraints: constraints),
    );
  }
}

class _MostrarConstraint extends StatelessWidget {
  final BoxConstraints constraints;
  const _MostrarConstraint({required this.constraints});

  @override
  Widget build(BuildContext context) {
    final infinita = !constraints.hasBoundedHeight;
    return Padding(
      padding: const .all(8.0),
      child: Column(
        children: [
          SelectableText('$constraints'),
          SizedBox(height: 8),
          Text(
            infinita
                ? 'MaxHeight = INfinity -> Expanded/Flexible/Spacer QUEBRAM aqui'
                : 'maxHeight finito -> Expanded/Flexible/Spacer funcionam aqui',
          ),
        ],
      ),
    );
  }
}

class _Cartao extends StatelessWidget {
  const _Cartao({required this.titulo, required this.cor, required this.child});

  final String titulo;
  final Color cor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: cor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              titulo,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

// exemplo_02_01_constraint_inicio.dart
// Duas caixas na tela, lado a lado na vertical.
//
// A de cima tem um conteúdo direto no Scaffold.
// A de baixo tem o mesmo conteúdo, mas dentro de um SingleChildScrollView.
//
// Por enquanto as duas mostram só um texto fixo. O que a gente quer descobrir
// é qual constraint de altura cada uma recebe do pai.

import 'package:material_ui/material_ui.dart';

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
    return const Padding(
      padding: EdgeInsets.all(12),
      child: Text('Qual altura o pai me deu?'),
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

// exemplo_02_construtores_inicio.dart
// Um cardápio de quatro itens, digitados na mão, num ListView(children:).
//
// Para quatro itens fixos isso está perfeito: não existe builder que melhore.
//
// A pergunta que abre o próximo passo: e quando a lista não tem quatro itens,
// e sim mil, vindos de uma API?

import 'package:material_ui/material_ui.dart';

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

  static const _menu = ['Café', 'Pão de queijo', 'Suco', 'Bolo'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Os construtores do ListView')),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          for (final item in _menu) Card(child: ListTile(title: Text(item))),
        ],
      ),
    );
  }
}

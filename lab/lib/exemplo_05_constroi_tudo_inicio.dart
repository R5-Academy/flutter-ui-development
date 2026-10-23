// exemplo_05_constroi_tudo_inicio.dart
// Mil itens dentro de um SingleChildScrollView.
//
// Role a lista. Funciona: não estoura, não dá erro, o scroll é suave.
//
// A pergunta que a tela ainda não responde: para mostrar os ~11 itens que
// cabem na tela (cada um tem 48 px, a janela abaixo do AppBar tem 544),
// quantos o Flutter construiu?

import 'package:material_ui/material_ui.dart';

// Troque este número e dê hot reload para sentir a diferença.
const _quantos = 1000;

void main() => runApp(const AppConstroiTudo());

class AppConstroiTudo extends StatelessWidget {
  const AppConstroiTudo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quantos ele constrói?',
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const TelaLista(),
    );
  }
}

class TelaLista extends StatelessWidget {
  const TelaLista({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quantos filhos ele constrói?')),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            _quantos,
            (i) => ListTile(
              dense: true,
              leading: CircleAvatar(
                radius: 14,
                child: Text('$i', style: const TextStyle(fontSize: 10)),
              ),
              title: Text('Item $i'),
            ),
          ),
        ),
      ),
    );
  }
}

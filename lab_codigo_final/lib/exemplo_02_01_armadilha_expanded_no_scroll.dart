// exemplo_02_02_armadilha_expanded_no_scroll.dart
// ! ESTE ARQUIVO QUEBRA DE PROPÓSITO. É para rodar e ver o erro.
//
// ! O erro que aparece no console:
// !
// !   RenderFlex children have non-zero flex but incoming height
// !   constraints are unbounded.
//
// Copie essa mensagem no Google e você acha dez mil issues. É um dos erros
// mais comuns de quem está começando com scroll no Flutter.

import 'package:flutter/material.dart';

void main() => runApp(const AppExpandedErrado());

class AppExpandedErrado extends StatelessWidget {
  const AppExpandedErrado({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expanded dentro do scroll',
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const TelaQuebrada(),
    );
  }
}

class TelaQuebrada extends StatelessWidget {
  const TelaQuebrada({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Isto quebra')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: 120, color: Colors.amber),
            // ! ESTA LINHA EXPLODE.
            // ! Expanded pede "todo o espaço que sobrou no eixo vertical".
            Expanded(child: Container(color: Colors.red)),
            Container(height: 120, color: Colors.green),
          ],
        ),
      ),
    );
  }
}

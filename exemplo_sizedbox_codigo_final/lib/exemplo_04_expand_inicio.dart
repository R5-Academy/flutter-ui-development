// exemplo_04_expand_inicio.dart
// Ponto de partida: o quadrado do exemplo 01, agora em teal — 120x120 no meio da
// tela, com o tamanho vindo do SizedBox.
//
// Só que agora não queremos um número. Queremos o OPOSTO do shrink: encher tudo
// o que o pai permitir, sem saber quanto é isso.
//
// ? Que número eu escrevo no width/height para dizer "o máximo que couber"?

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ExemploExpand()));

class ExemploExpand extends StatelessWidget {
  const ExemploExpand({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SizedBox.expand')),
      body: const Center(
        child: SizedBox.expand(child: ColoredBox(color: Colors.teal)),
      ),
    );
  }
}

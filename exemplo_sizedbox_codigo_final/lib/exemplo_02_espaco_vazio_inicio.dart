// exemplo_02_espaco_vazio_inicio.dart
// Ponto de partida: dois textos empilhados, grudados um no outro.
//
// É o cenário mais comum de todos num app: falta respiro entre eles.
//
// * Andaime: Column ainda não foi ensinada (é da próxima seção) — aqui ela só
// * empilha os dois textos, e o `mainAxisSize: min` a faz encolher para o
// * conteúdo em vez de esticar na altura toda. O foco é o espaço (ou a falta
// * dele) entre os textos.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: EspacoVazio()));

class EspacoVazio extends StatelessWidget {
  const EspacoVazio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SizedBox: espaço vazio')),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Título', style: TextStyle(fontSize: 24)),
            SizedBox(height: 16),
            Text('Subtítulo', style: TextStyle(fontSize: 16)),
            SizedBox(height: 48),
            Text('O mesmo vao, pintado para ficar visivel'),
            SizedBox(height: 8),
            ColoredBox(
              color: Colors.amber,
              child: SizedBox(width: 200, height: 16),
            ),
          ],
        ),
      ),
    );
  }
}

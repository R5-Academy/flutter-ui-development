// exemplo_02_row_vira_column_inicio.dart
// Ponto de partida: a Row da aula anterior, com mainAxisAlignment.center.
//
// Os três blocos estão agrupados no meio da tela, na horizontal.
//
// Deixe este arquivo rodando numa janela e abra o _completo em outra. A
// diferença entre os dois é UMA palavra.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: RowViraColumn()));

class RowViraColumn extends StatelessWidget {
  const RowViraColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agora é Row')),
      body: const Center(
        // mainAxisAlignment.center: no eixo principal, agrupa os filhos no meio.
        // Na Row, isso centraliza na HORIZONTAL.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Bloco(cor: Colors.red, rotulo: '1'),
            _Bloco(cor: Colors.green, rotulo: '2'),
            _Bloco(cor: Colors.blue, rotulo: '3'),
          ],
        ),
      ),
    );
  }
}

class _Bloco extends StatelessWidget {
  const _Bloco({required this.cor, required this.rotulo});

  final Color cor;
  final String rotulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 80,
      color: cor,
      alignment: Alignment.center,
      child: Text(
        rotulo,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

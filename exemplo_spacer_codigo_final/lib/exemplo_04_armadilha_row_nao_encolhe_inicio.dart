// exemplo_04_armadilha_row_nao_encolhe_inicio.dart
// Ponto de partida: uma pílula de status — ícone à esquerda, texto à direita.
//
// A pílula pede `mainAxisSize: MainAxisSize.min` justamente para abraçar o
// conteúdo: ela deveria ser um selo pequeno no meio da tela.
//
// ! Rode e compare com o que você esperava: a pílula ocupa a LARGURA TODA.
// ! E não aparece erro nenhum — nem faixa listrada, nem tela vermelha, nem
// ! mensagem no console. O `min` está escrito ali e simplesmente não fez nada.
//
// Quem anulou o `min`? Só tem um suspeito novo nesta linha.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: RowNaoEncolhe()));

class RowNaoEncolhe extends StatelessWidget {
  const RowNaoEncolhe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spacer: por que o Row não encolhe')),
      body: const Center(
        child: Column(
          children: [
            _Pilula(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, size: 20),
                  // Spacer(),
                  SizedBox(width: 20),
                  Text('Salvo'),
                ],
              ),
            ),
            SizedBox(height: 24),
            _Pilula(
              child: Row(
                children: [
                  Icon(Icons.check_circle, size: 20),
                  Spacer(),
                  Text('Salvo'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Pilula extends StatelessWidget {
  const _Pilula({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.teal.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
      ),
      child: child,
    );
  }
}

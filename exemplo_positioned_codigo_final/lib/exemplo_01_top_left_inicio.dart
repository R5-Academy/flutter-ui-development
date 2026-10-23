// exemplo_01_top_left_inicio.dart
// Ponto de partida: um Stack de 300x300 com duas caixas soltas.
//
// ! As duas empilharam no mesmo canto — o `topStart` padrão do alignment. É o
// ! que a aula passada ensinou, e é o limite dela: o alignment vale para TODOS
// ! os filhos de uma vez.
//
// E se você quisesse uma caixa num canto e outra no canto oposto?

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaTopLeft()));

class TelaTopLeft extends StatelessWidget {
  const TelaTopLeft({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Positioned: top + left')),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          color: Colors.grey.shade200,
          child: Stack(
            children: [
              const Center(child: Text('fundo do Stack')),
              Positioned(
                top: 24,
                left: 24,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.red.shade400,
                  child: const Text(
                    'caixa 1',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                right: 16,
                bottom: 16,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.blue.shade400,
                  child: const Text(
                    'caixa 2',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

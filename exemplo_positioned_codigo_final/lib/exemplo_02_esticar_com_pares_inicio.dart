// exemplo_02_esticar_com_pares_inicio.dart
// Ponto de partida: três elementos ancorados com UM lado de cada eixo, como no
// bloco anterior.
//
// ! A barra do topo tem só a largura do próprio texto — mas queríamos uma barra
// ! de ponta a ponta. A faixa lateral tem só a altura do conteúdo. E o bloco
// ! laranja depende do tamanho do filho.
//
// Com um lado só, o Positioned apenas ANCORA: o filho recebe uma constraint
// ILIMITADA naquele eixo e escolhe o próprio tamanho. Para o Positioned definir
// também o tamanho, é preciso dar o outro lado.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaEsticar()));

class TelaEsticar extends StatelessWidget {
  const TelaEsticar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Positioned: esticar com pares')),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          color: Colors.grey.shade200,
          child: Stack(
            children: [
              Positioned(
                top: 12,
                left: 12,
                right: 12,
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  color: Colors.teal.shade400,
                  child: const Text(
                    'left + right Estica na horizontal',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                top: 64,
                bottom: 64,
                left: 12,
                child: Container(
                  width: 60,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  color: Colors.deepPurple.shade400,
                  child: const Text(
                    'top + Bottom Também estica',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const Positioned(
                top: 84,
                right: 12,
                width: 100,
                height: 100,
                child: ColoredBox(
                  color: Colors.orange,
                  child: Center(child: Text('sem tamanho\nfixo')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

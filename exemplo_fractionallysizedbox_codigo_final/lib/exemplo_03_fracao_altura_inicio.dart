// exemplo_03_fracao_altura_inicio.dart
// Ponto de partida: a mesma ideia do bloco 1, agora no eixo vertical.
//
// * heightFactor 0.5 = metade da ALTURA que o pai oferece. widthFactor null
// * aqui, então a largura passa direto (o painel fica com a largura toda).
//
// ! Só que ele ficou FLUTUANDO no meio da tela — é o alignment padrão (center)
// ! agindo no eixo vertical. Um painel de meia altura solto no meio não parece
// ! nada: nem bottom sheet, nem banner.
//
// O SizedBox.expand é o mesmo do exemplo_01: ele transforma o loose do body em
// tight, para que a caixa ocupe a tela inteira e sobre espaço para o alignment
// posicionar o painel.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DemoFracaoAltura()));

class DemoFracaoAltura extends StatelessWidget {
  const DemoFracaoAltura({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const .only(top: 8.0),
        child: const SizedBox.expand(
          child: FractionallySizedBox(
            heightFactor: 0.5,
            alignment: .bottomCenter,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: .vertical(top: .circular(50)),
              ),
              child: Center(
                child: Text(
                  'Painel a meia tela',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

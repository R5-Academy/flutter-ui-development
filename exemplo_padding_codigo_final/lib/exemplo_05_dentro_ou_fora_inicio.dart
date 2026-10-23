// exemplo_05_dentro_ou_fora_inicio.dart
// Ponto de partida: Padding POR FORA do ColoredBox.
//
// A faixa cinza é a área do banner — o espaço que ele tem para ocupar. Dentro
// dela, o verde-água deveria cobrir tudo e o texto deveria ter respiro.
//
// ! Olhe o resultado: sobrou uma borda cinza de 20px em volta do verde, e o
// ! texto está encostado no verde. O padding não deu respiro ao TEXTO: ele
// ! empurrou a CAIXA COLORIDA para dentro, virando quase um "margin".
//
// Se era isso que você queria, ótimo. Se você queria a cor até a borda da
// faixa, o conserto é trocar a ordem dos dois widgets.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Demo()));

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // A faixa: largura toda, 120 de altura. Ela é a referência visual —
        // sem ela não daria para VER a borda que o padding abre.
        color: const Color(0xFFCFD8DC),
        width: double.infinity,
        height: 120,
        child: ColoredBox(
          color: Color(0xFF80CBC4),
          child: const Padding(
            padding: EdgeInsets.all(20),
            child: Text('Padding por fora da cor'),
          ),
        ),
      ),
    );
  }
}

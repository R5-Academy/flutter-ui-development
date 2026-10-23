// exemplo_04_icontheme_inicio.dart
// Ponto de partida: uma barra de status com três ícones, cada um repetindo
// `color` e `size`.
//
// ! São três ícones agora. Numa tela real seriam quinze — e o dia em que o
// ! designer trocar o roxo, você edita quinze linhas.
//
// Dá para configurar o ambiente uma vez e deixar os filhos herdarem.

import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    theme: ThemeData(iconTheme: IconThemeData(color: Colors.red)),
    home: HerancaDeEstilo(),
  ),
);

class HerancaDeEstilo extends StatelessWidget {
  const HerancaDeEstilo({super.key});

  @override
  Widget build(BuildContext context) {
    final iconTheme = Theme.of(context).iconTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('IconTheme')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Cada ícone repete cor e tamanho:'),
            SizedBox(height: 12),
            IconTheme(
              data: iconTheme.copyWith(size: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi),
                  SizedBox(width: 20),
                  Icon(Icons.bluetooth),
                  SizedBox(width: 20),
                  Icon(Icons.battery_full),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

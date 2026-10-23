// exemplo_05_icontheme_inicio.dart
// Ponto de partida: uma barra de status com três ícones, cada um repetindo
// `color` e `size`.
//
// ! São três ícones agora. Numa tela real seriam quinze — e o dia em que o
// ! designer trocar o roxo, você edita quinze linhas.
//
// Dá para configurar o ambiente uma vez e deixar os filhos herdarem.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: HerancaDeEstilo()));

class HerancaDeEstilo extends StatelessWidget {
  const HerancaDeEstilo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('IconTheme')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Cada ícone repete cor e tamanho:'),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wifi, color: Colors.deepPurple, size: 40),
                SizedBox(width: 20),
                Icon(Icons.bluetooth, color: Colors.deepPurple, size: 40),
                SizedBox(width: 20),
                Icon(Icons.battery_full, color: Colors.deepPurple, size: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

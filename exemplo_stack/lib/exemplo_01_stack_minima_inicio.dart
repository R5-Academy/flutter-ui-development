// exemplo_01_stack_minima_inicio.dart
// Ponto de partida: duas caixas numa Column, uma DEPOIS da outra.
//
// É o que sabemos fazer até aqui: Row, Column e Wrap arranjam os filhos em
// fluxo, um seguido do outro.
//
// E se a gente quisesse a caixa rosa EM CIMA da azul, na mesma região da tela?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: StackMinima()));

class StackMinima extends StatelessWidget {
  const StackMinima({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stack mínima')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 200, height: 200, color: Colors.blue),
            Container(
              width: 120,
              height: 120,
              color: Colors.pink.withValues(alpha: 0.8),
            ),
          ],
        ),
      ),
    );
  }
}

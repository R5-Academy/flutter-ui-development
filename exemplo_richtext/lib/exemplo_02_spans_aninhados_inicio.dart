// exemplo_02_spans_aninhados_inicio.dart
// Ponto de partida: um parágrafo com dois trechos destacados, cada um repetindo
// o estilo por extenso.
//
// ! Repare na duplicação: "Ana Souza" e " (admin)" declaram o MESMO azul e o
// ! MESMO negrito. Se o designer trocar o tom de azul, você edita nos dois
// ! lugares — e um dia esquece um.
//
// Os spans sabem herdar estilo. Dá para dizer o azul e o negrito uma vez só.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoAninhados()));

class DemoAninhados extends StatelessWidget {
  const DemoAninhados({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Text.rich(
            TextSpan(
              // Base do parágrafo: todo mundo herda isto.
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
                height: 1.5,
              ),
              children: [
                const TextSpan(text: 'Termos aceitos por '),
                TextSpan(
                  text: 'Ana Souza',
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: ' (admin)',
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const TextSpan(text: ' em 14/07/2026.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

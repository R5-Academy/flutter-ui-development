// exemplo_02_expanded_ellipsis_inicio.dart
// Ponto de partida: exatamente o layout que estourou no exemplo_01.
// A faixa listrada está aí. Agora vamos consertar.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaConserto()));

class TelaConserto extends StatelessWidget {
  const TelaConserto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Overflow: o conserto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('O layout do exemplo 01, ainda estourando:'),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.local_offer),
                const SizedBox(width: 8),
                Text(
                  'Promoção relâmpago: fone de ouvido bluetooth com '
                  'cancelamento de ruído por tempo limitado',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(width: 8),
                FilledButton(onPressed: () {}, child: const Text('Comprar')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

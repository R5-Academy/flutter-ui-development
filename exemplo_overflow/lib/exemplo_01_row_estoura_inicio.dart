// exemplo_01_row_estoura_inicio.dart
// Ponto de partida: uma Row com ícone, título e botão. Tudo cabe, tudo certo.
//
// Agora troque o texto curto pelo texto de verdade — aquele que vem do backend,
// com o nome completo da promoção — e rode de novo.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaProblema()));

class TelaProblema extends StatelessWidget {
  const TelaProblema({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Overflow: o problema')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Com um título curto, cabe todo mundo na linha.'),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.local_offer),
                const SizedBox(width: 8),
                Text(
                  'Promoção',
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

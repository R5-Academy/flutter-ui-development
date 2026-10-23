// exemplo_01_row_estoura_inicio.dart
// Ponto de partida: uma Row com ícone, título e botão. Tudo cabe, tudo certo.
//
// Agora troque o texto curto pelo texto de verdade — aquele que vem do backend,
// com o nome completo da promoção — e rode de novo.

import 'package:flutter/material.dart';

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
            const Text(
              'Repare na faixa listrada na borda direita e no erro do console',
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.local_offer),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Promoção relampago: fone de ouvido bluetooth com '
                    'cancelamento de ruido por tempo limitado',
                    maxLines: 2,
                    overflow: .ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(onPressed: () {}, child: const Text('Comprar')),
              ],
            ),
            SizedBox(height: 32),
            Text('A mesma coisa na vertical: a faixa muda de borda'),
            SizedBox(height: 16),
            SizedBox(
              child: Column(
                children: [
                  _CartaoDoPedido(titulo: 'Pedido #001'),
                  _CartaoDoPedido(titulo: 'Pedido #002'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartaoDoPedido extends StatelessWidget {
  final String _titulo;

  const _CartaoDoPedido({required this._titulo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(child: Center(child: Text(_titulo))),
    );
  }
}

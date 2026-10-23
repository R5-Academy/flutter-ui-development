// exemplo_03_expanded_x_flexible_inicio.dart
// Ponto de partida: o `Flexible(fit: FlexFit.tight)` do bloco anterior.
//
// Funciona — mas é verboso para algo tão comum. Escrever `fit: FlexFit.tight`
// toda vez que você quer um filho preenchendo o espaço cansa.
//
// O Flutter já tem um atalho para exatamente esse caso.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaComparacao()));

class TelaComparacao extends StatelessWidget {
  const TelaComparacao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expanded x Flexible')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Flexible (loose) — encolhe até o conteúdo:'),
            SizedBox(height: 8),
            Row(
              children: [
                // * loose: [min: 0, max: espaço]. A barra abraça o texto 'Curto'.
                Flexible(child: _Barra('Curto', Colors.teal)),
              ],
            ),

            SizedBox(height: 32),

            Text('Flexible(fit: FlexFit.tight) — força preencher:'),
            SizedBox(height: 8),
            Row(
              children: [Expanded(child: _Barra('Curto', Colors.deepOrange))],
            ),
          ],
        ),
      ),
    );
  }
}

// Mesmo filho nos dois casos, para a comparação ser justa: só muda o fit.
class _Barra extends StatelessWidget {
  const _Barra(this.texto, this.cor);

  final String texto;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cor,
      padding: const EdgeInsets.all(16),
      child: Text(texto, style: const TextStyle(color: Colors.white)),
    );
  }
}

// exemplo_01_card_basico_inicio.dart
// Ponto de partida: o bloco do plano Premium — título e descrição — no meio de
// uma tela cinza.
//
// ! O conteúdo está certo, mas não parece um BLOCO. É texto derramado sobre o
// ! fundo: nada diz onde a informação começa e onde termina.
//
// Falta a superfície embaixo dele.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: CardBasico()));

class CardBasico extends StatelessWidget {
  const CardBasico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fundo cinza: é sobre ele que a sombra de um Card apareceria.
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: const Text('Card básico')),
      body: Center(
        child: Card(
          child: Padding(
            padding: const .all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Plano Premium',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black.withValues(alpha: 0.87),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Acesso a todos os cursos, sem anúncios.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Colors.black.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

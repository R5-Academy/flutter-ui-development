// exemplo_04_titulo_subtitulo_inicio.dart
// Ponto de partida: o card de produto com os três textos no lugar — e nenhum
// estilo.
//
// ! Título, descrição e preço saem exatamente iguais. Não dá para saber o que é
// ! mais importante batendo o olho, e a descrição longa empurra o preço para
// ! longe.
//
// Este bloco junta tudo o que a aula viu: peso, tamanho, cor, height, maxLines
// e ellipsis, num componente com cara de app.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DemoCard()));

class DemoCard extends StatelessWidget {
  const DemoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Center(
          child: Container(
            // width: 300,
            margin: .all(10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Fone de ouvido Bluetooth com cancelamento de ruído',
                  maxLines: 1,
                  overflow: .ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: .w700),
                ),
                const SizedBox(height: 4),
                Text(
                  '30 horas de bateria, conexão multiponto e estojo de recarga '
                  'rápida.',
                  maxLines: 2,
                  overflow: .ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.3,
                    color: Colors.black.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    r'R$ 349,90',
                    textAlign: .end,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: .w900,
                      color: Colors.green,
                    ),
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

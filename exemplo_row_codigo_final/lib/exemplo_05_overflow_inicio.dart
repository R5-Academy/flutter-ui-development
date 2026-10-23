// exemplo_05_overflow_inicio.dart
// Ponto de partida: um aviso curto numa linha. Ícone + texto, tudo cabendo.
//
// O fundo laranja marca a largura que o texto pediu. Agora troque o texto curto
// pelo aviso de verdade — aquele que veio do backend, com a mensagem completa.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaOverflow()));

class TelaOverflow extends StatelessWidget {
  const TelaOverflow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Overflow no Row')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.info, size: 40),
            const SizedBox(width: 8),
            Container(
              color: Colors.orange.withValues(alpha: 0.3),
              child: const Text(
                'Este é um texto propositalmente longo que não cabe na largura '
                'da tela e por isso faz o Row estourar com a faixa de overflow',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

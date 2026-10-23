// exemplo_04_badge_no_avatar_inicio.dart
// Ponto de partida: avatar e badge no mesmo Stack, sem posicionar nada.
//
// ! O badge ficou em cima do rosto, no canto superior esquerdo — o alignment
// ! padrão. Todo app põe esse contador no canto SUPERIOR DIREITO.
//
// * Repare numa diferença importante em relação aos blocos anteriores: aqui o
// * Stack NÃO tem tamanho fixo. Quem dita o tamanho dele é o avatar, que é o
// * filho não-posicionado. O Stack mede exatamente 72x72 (o avatar de radius 36).
//
// ? E se o badge tivesse que ficar montado na BORDA do avatar, meio para dentro e
// ? meio para fora, como nos apps de mensagem? Dá para pedir uma distância
// ? negativa?

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaBadge()));

class TelaBadge extends StatelessWidget {
  const TelaBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Badge no canto do avatar')),
      body: Center(child: AvatarComBadge(quantidade: 3)),
    );
  }
}

class AvatarComBadge extends StatelessWidget {
  const AvatarComBadge({super.key, required this.quantidade});

  final int quantidade;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: .none,
      children: [
        // * Filho não-posicionado: é ele quem dá o tamanho ao Stack (72x72).
        const CircleAvatar(
          radius: 36,
          backgroundColor: Colors.blueGrey,
          child: Icon(Icons.person, size: 40, color: Colors.white),
        ),

        Positioned(
          top: -4,
          right: -6,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
            child: Text(
              '$quantidade',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

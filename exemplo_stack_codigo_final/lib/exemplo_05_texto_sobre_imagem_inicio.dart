// exemplo_05_texto_sobre_imagem_inicio.dart
// Ponto de partida: as duas composições clássicas, mas cruas.
//
// ! No card, o título branco cai justamente na parte CLARA da foto e some.
// ! Falta o scrim (a faixa escura) que garante legibilidade.
// ! No avatar não tem selo nenhum ainda — ele é a camada que vamos empilhar.
//
// A "imagem" é simulada por um Container com gradiente, para o exemplo rodar
// sem depender de assets. Numa tela real, troque por um Image.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TextoSobreImagem()));

class TextoSobreImagem extends StatelessWidget {
  const TextoSobreImagem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Texto sobre imagem')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_CardDeMidia(), SizedBox(height: 40), _AvatarComBadge()],
        ),
      ),
    );
  }
}

class _CardDeMidia extends StatelessWidget {
  const _CardDeMidia();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 300,
        height: 180,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            // Camada 1: a "foto" — escura no topo, clara embaixo.
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.7),
                    Colors.black.withValues(alpha: 0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
              ),
            ),

            // Camada 2: o texto, direto sobre a foto.
            const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Praia do Rosa',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Santa Catarina',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvatarComBadge extends StatelessWidget {
  const _AvatarComBadge();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.teal,
            child: Icon(Icons.person, size: 44, color: Colors.white),
          ),
          Align(
            alignment: .topRight,
            child: Container(
              padding: .all(6),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: .circle,
                border: .all(color: Colors.white, width: 2),
              ),
              child: Text(
                '3',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: .bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

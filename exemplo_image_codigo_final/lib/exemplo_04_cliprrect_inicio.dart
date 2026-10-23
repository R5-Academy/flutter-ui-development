// exemplo_04_cliprrect_inicio.dart
// Ponto de partida: o card de uma notícia, com a capa em cima e o avatar do
// autor embaixo.
//
// ! Duas coisas estão erradas na tela, e as duas são o mesmo problema:
// !   1. o card tem cantos arredondados, mas a capa dentro dele é um retângulo
// !      duro — os cantos da foto estouram a curva do card;
// !   2. o avatar do autor é um quadrado, e avatar de gente é redondo.
//
// ! Procure um `borderRadius` no `Image` para resolver: não existe. A imagem
// ! desenha os pixels do arquivo, e arquivo de imagem é sempre retangular.
//
// A forma não vem de dentro da imagem. Vem de fora.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: CardDaNoticia()));

class CardDaNoticia extends StatelessWidget {
  const CardDaNoticia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: .circular(16),
                  child: Image.network(
                    'https://picsum.photos/300/200',
                    width: 300,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(
                          width: 300,
                          height: 200,
                          child: Center(child: Icon(Icons.broken_image)),
                        ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Flutter 4 chega com compilação mais rápida',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        'https://picsum.photos/300/200?random=8',
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox(
                              width: 48,
                              height: 48,
                              child: Icon(Icons.person),
                            ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text('por Ana Prado'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

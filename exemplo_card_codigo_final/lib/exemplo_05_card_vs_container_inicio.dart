// exemplo_05_card_vs_container_inicio.dart
// Ponto de partida: dois blocos desenhados com `Container` + `BoxDecoration` —
// o jeito que a gente escreve antes de conhecer o Card.
//
// ! Olhe o primeiro: doze linhas para chegar num cartão branco com sombra. E
// ! repare que os números (raio 12, blur 6, offset 0,3, alpha 0.2) foram
// ! CHUTADOS. Não vieram de lugar nenhum — não são o padrão do Material, são o
// ! que pareceu bonito na hora.
//
// ! Numa equipe, o próximo dev chuta outros. Aí cada tela do app tem um
// ! cartão com uma sombra diferente.
//
// O segundo bloco, o do gradiente, é outro caso — guarde-o.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: CardVsContainer()));

class CardVsContainer extends StatelessWidget {
  const CardVsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: const Text('Card vs Container')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ! Uma superfície comum, escrita inteira na mão.
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text('Uma superfície comum, escrita na mão'),
              ),
            ),
            const SizedBox(height: 16),

            // Este aqui pede um gradiente de fundo.
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Colors.deepPurple, Colors.indigo],
                ),
              ),
              child: const Text(
                'Um bloco com gradiente',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

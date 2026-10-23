// exemplo_05_texto_sobre_imagem_inicio.dart
// Ponto de partida: as duas composições clássicas, mas cruas.
//
// ! No card, o título branco cai justamente na parte CLARA da foto e some.
// ! Falta o scrim (a faixa escura) que garante legibilidade.
// ! No avatar não tem selo nenhum ainda — ele é a camada que vamos empilhar.
//
// A "imagem" é simulada por um Container com gradiente, para o exemplo rodar
// sem depender de assets. Numa tela real, troque por um Image.

import 'package:material_ui/material_ui.dart';

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
          children: [_CardDeMidia(), SizedBox(height: 40), _Avatar()],
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
                  colors: [Colors.indigo, Colors.amber.shade200],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
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

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 40,
      backgroundColor: Colors.teal,
      child: Icon(Icons.person, size: 44, color: Colors.white),
    );
  }
}

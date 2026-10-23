// exemplo_03_positioned_fill_inicio.dart
// Ponto de partida: a "imagem" e o texto do rodapé, sem overlay.
//
// ! O texto branco está direto sobre a foto. Numa imagem clara ele sumiria.
//
// Falta uma camada escura entre os dois — e ela precisa cobrir o Stack inteiro.
// Escrever os quatro lados zerados funcionaria, mas existe um atalho.
//
// A "imagem" é um gradiente colorido, para o exemplo rodar sem asset externo.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaFill()));

class TelaFill extends StatelessWidget {
  const TelaFill({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Positioned.fill: overlay')),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 200,
          child: Stack(
            children: [
              // Camada de baixo (a "imagem"), com os quatro lados escritos à mão.
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.indigo.shade300, Colors.pink.shade300],
                    ),
                  ),
                ),
              ),

              // Texto ancorado no rodapé: left + right + bottom.
              const Positioned(
                left: 16,
                right: 16,
                bottom: 12,
                child: Text(
                  'Praia do Rosa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

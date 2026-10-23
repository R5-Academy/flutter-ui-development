// exemplo_02_variantes_inicio.dart
// Ponto de partida: o ícone de engrenagem no estilo padrão.
//
// * `Icons.settings`, sem sufixo, é o estilo **filled** (preenchido).
//
// Só que o app que você está fazendo usa contornos finos em tudo, e esta
// engrenagem sólida destoa. Você precisa de outra versão do MESMO símbolo.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Variantes()));

class Variantes extends StatelessWidget {
  const Variantes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Variantes de estilo')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _LinhaIcone(icone: Icons.star, rotulo: 'start (filled)'),
            _LinhaIcone(icone: Icons.star_half, rotulo: 'start (outline)'),
            _LinhaIcone(icone: Icons.star_outline, rotulo: 'start (outline)'),
            _LinhaIcone(icone: Icons.star_rounded, rotulo: 'start (rounded)'),
            _LinhaIcone(icone: Icons.star_sharp, rotulo: 'start (sharp)'),
          ],
        ),
      ),
    );
  }
}

class _LinhaIcone extends StatelessWidget {
  const _LinhaIcone({required this.icone, required this.rotulo});

  final IconData icone;
  final String rotulo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icone, size: 40, color: Colors.amber),
          const SizedBox(width: 16),
          Text(rotulo, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

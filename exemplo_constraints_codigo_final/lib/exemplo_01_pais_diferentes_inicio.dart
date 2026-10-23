// exemplo_01_pais_diferentes_inicio.dart
// Ponto de partida: o mistério da aula, sozinho na tela.
// O bloco pede 100x100. Rode e meça: ele saiu com 280x130, o tamanho do pai.
//
// Não é bug. A partir daqui a gente descobre por quê.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaMesmoBloco()));

// Só o rótulo em cima do caso, para a tela ficar legível.
class _Caso extends StatelessWidget {
  const _Caso({required this.titulo, required this.child});

  final String titulo;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class Bloco extends StatelessWidget {
  const Bloco({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.indigo,
      child: Center(
        child: Text(
          'Eu Quero 100x100',
          style: TextStyle(color: Colors.white),
          textAlign: .center,
        ),
      ),
    );
  }
}

class TelaMesmoBloco extends StatelessWidget {
  const TelaMesmoBloco({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('O mesmo bloco, pais diferentes')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'O bloco pede sempre 100x100. Confira o que aconteceu:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          _Caso(
            titulo: 'Dentro de um Container de 280x130',
            child: Container(
              width: 280,
              height: 130,
              color: Colors.grey,
              child: Bloco(),
            ),
          ),
          const SizedBox(height: 20),
          _Caso(
            titulo: 'Dentro de um Container de 280x130',
            child: Container(
              width: 280,
              height: 130,
              color: Colors.grey,
              alignment: .center,
              child: Bloco(),
            ),
          ),

          _Caso(
            titulo: 'Dentro de um Container de 280x130',
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(Size(280, 130)),
              child: Bloco(),
            ),
          ),

          _Caso(
            titulo: 'Dentro de um Container de 280x130',
            child: ConstrainedBox(
              constraints: BoxConstraints.loose(Size(280, 130)),
              child: Center(child: Bloco()),
            ),
          ),
        ],
      ),
    );
  }
}

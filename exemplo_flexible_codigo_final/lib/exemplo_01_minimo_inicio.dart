// exemplo_01_minimo_inicio.dart
// Ponto de partida: um nome de usuário longo numa Row.
//
// ! ESTOURA de propósito — o overflow amarelo e preto de sempre. O texto pede a
// ! largura de todos os caracteres e ninguém lhe deu um teto.
//
// A aula passada resolveu isso com Expanded. Agora vamos conhecer o widget
// GERAL que está por trás dele.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaMinimo()));

class TelaMinimo extends StatelessWidget {
  const TelaMinimo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flexible: o mínimo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.person, size: 40),
            const SizedBox(width: 18),
            Flexible(
              child: LayoutBuilder(
                builder: (_, constrains) {
                  debugPrint(constrains.maxWidth.toString());
                  return Text(
                    'Este é um nome de usuário bem longo que jamais caberia numa '
                    'linha só',
                    style: Theme.of(context).textTheme.titleMedium,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// exemplo_04_01_tight_inicio.dart
// Ponto de partida: a primeira armadilha. Pedimos 16/9 e recebemos um QUADRADO.
//
// ! O SizedBox fixa largura E altura -> constraints TIGHT. O AspectRatio não
// ! tem folga nenhuma: ele devolve o tamanho exigido e IGNORA a proporção.
// ! Resultado: 250x250, não um 16/9.
//
// Repare que não há erro no console. A tela simplesmente sai errada, em
// silêncio — que é o pior tipo de bug de layout.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaArmadilhaTight()));

class TelaArmadilhaTight extends StatelessWidget {
  const TelaArmadilhaTight({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Armadilha: pai tight')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _Rotulo('Pai tight (250x250) ignora o 16/9'),
          // ! O Align é o que permite ao SizedBox valer 250 de largura: a
          // ! ListView entrega a largura toda em constraints tight, e contra
          // ! tight o SizedBox seria ignorado.
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 250,
              height: 250,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: ColoredBox(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Rotulo extends StatelessWidget {
  const _Rotulo(this.texto);

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(texto, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

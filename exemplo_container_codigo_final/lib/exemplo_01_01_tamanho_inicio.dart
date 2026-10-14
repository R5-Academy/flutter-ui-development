// exemplo_01_01_tamanho_inicio.dart
// Ponto de partida: um Container vazio como corpo da tela.
//
// Rode e responda: por que ele encheu a tela inteira?
// Ninguém pediu tamanho nenhum aqui.
//
// * Este é o primeiro dos TRÊS tamanhos que o MESMO Container assume nesta aula:
// *   1. vazio           -> ESTICA e enche a tela  (este arquivo: 400x800)
// *   2. com um filho    -> ENCOLHE no filho       (exemplo_01_03: 36x26)
// *   3. com `alignment` -> ESTICA de novo         (exemplo_01_01_completo)
// * Nenhum dos três é capricho do Container: os três saem da mesma regra de
// * constraints que a seção anterior inteira ensinou.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DemoTamanho()));

class DemoTamanho extends StatelessWidget {
  const DemoTamanho({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: .center,
        width: 120,
        height: 120,
        color: Colors.blue,
        child: Text('OI'),
      ),
    );
  }
}

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

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoTamanho()));

class DemoTamanho extends StatelessWidget {
  const DemoTamanho({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // * Container VAZIO. O Container não tem tamanho próprio: sem filho e sem
      // * width/height, quem decide é o PAI. Como a área do body é "bounded"
      // * (tem limites definidos), o Container expande e enche a tela.
      body: Container(color: Colors.blue),
    );
  }
}

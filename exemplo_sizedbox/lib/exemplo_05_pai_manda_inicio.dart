// exemplo_05_pai_manda_inicio.dart
// Ponto de partida: a armadilha clássica. Um SizedBox de 50x50 pedindo um
// quadradinho vermelho.
//
// ! Rode: a tela fica TODA vermelha. O 50x50 foi ignorado.
//
// * runApp coloca este SizedBox direto sob a tela. A tela impõe uma constraint
// * TIGHT (seja exatamente do meu tamanho). Essa constraint VENCE o 50x50.
// * width/height do SizedBox não são garantidos — o pai manda.
//
// * E vale nos DOIS eixos: a raiz manda tight na largura e na altura. Medido numa
// * tela de 800x600, o vermelho sai 800x600 — e sai 800x600 até se você apagar o
// * `height` e deixar só `width: 50`.
//
// Sem MaterialApp o fundo é só o palco vazio (preto). Aqui a tela nem chega a
// aparecer: o vermelho cobre tudo.

import 'package:material_ui/material_ui.dart';

void main() {
  runApp(
    const SizedBox(width: 50, height: 50, child: ColoredBox(color: Colors.red)),
  );
}

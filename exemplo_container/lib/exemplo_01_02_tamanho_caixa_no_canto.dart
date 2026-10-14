// exemplo_01_02_tamanho_caixa_no_canto.dart
// Segundo passo: pedir width/height ao Container.
//
// Ele virou a caixa de 120x120 que pedimos. Mas foi parar no canto superior
// esquerdo — e a pergunta certa aqui é QUEM colocou ela lá.
//
// ! Não foi o Container. Um widget nunca escolhe a própria posição: ele informa
// ! o tamanho para cima, e o PAI decide onde encaixar. É a terceira parte do
// ! mantra da seção anterior — "constraints descem, tamanhos sobem, o pai
// ! posiciona". O pai aqui é o body do Scaffold, e ele posiciona em (0, 0).
//
// Este é o momento em que muita gente sai procurando um Center. Guarde a
// pergunta: para centralizar, precisamos de um PAI que alinhe. O Container sabe
// ser esse pai — veja o exemplo_01_03 e depois o _completo.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoTamanho()));

class DemoTamanho extends StatelessWidget {
  const DemoTamanho({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(width: 120, height: 120, color: Colors.blue),
    );
  }
}

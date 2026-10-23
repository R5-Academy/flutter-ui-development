// exemplo_05_fora_do_stack_inicio.dart
// A armadilha clássica: usar Positioned fora de um Stack.
//
// ! Este arquivo ERRA de propósito — mas cuidado com a palavra "quebra": NÃO há
// ! tela vermelha. O app abre, desenha, e o erro sai só no console. Deixe o
// ! terminal (ou a aba de erros do DevTools) à vista antes de rodar. Mensagem
// ! literal, medida:
// !
// !   Incorrect use of ParentDataWidget.
// !   The ParentDataWidget Positioned(left: 10.0, top: 10.0) wants to apply
// !   ParentData of type StackParentData to a RenderObject, which has been set
// !   up to accept ParentData of incompatible type ParentData.
// !   Usually, this means that the Positioned widget has the wrong ancestor
// !   RenderObjectWidget. Typically, Positioned widgets are placed directly
// !   inside Stack widgets.
// !   The offending Positioned is currently placed inside a ColoredBox widget.
//
// * A última linha é a mais útil: o Flutter dedura o pai errado pelo nome. Ele diz
// * ColoredBox, e não Container, porque `Container` com `color` é justamente um
// * ColoredBox por dentro.
//
// ! É a MESMA mensagem do Expanded fora do Flex (Layouts Flexíveis, aula de
// ! Expanded) — e pela mesma razão: Positioned é um ParentDataWidget. Ele não
// ! desenha nada, só anexa uma anotação de posição (StackParentData) para o pai
// ! Stack ler. Se o pai não for um Stack, ninguém sabe ler essa anotação, e o
// ! framework DESCARTA a anotação e desenha sem ela.
//
// ! O resultado dessa anotação descartada aparece na tela: o quadrado vermelho
// ! deveria ter 60x60 a 10px do canto, e sai 200x200 cobrindo o cinza inteiro
// ! (medido). Com a anotação jogada no lixo, o Positioned virou um invólucro que
// ! só repassa o filho, e as constraints apertadas de 200x200 do Container de fora
// ! chegam inteiras nele. O app não quebra: ele mente.
//
// (O flutter analyze passa; o erro só aparece ao rodar.)

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaArmadilha()));

class TelaArmadilha extends StatelessWidget {
  const TelaArmadilha({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Armadilha: Positioned sem Stack')),
      body: Center(
        // ! Positioned dentro de um Container, que não é Stack.
        child: Container(
          width: 200,
          height: 200,
          color: Colors.grey.shade200,
          child: Positioned(
            top: 10,
            left: 10,
            child: Container(width: 60, height: 60, color: Colors.red),
          ),
        ),
      ),
    );
  }
}

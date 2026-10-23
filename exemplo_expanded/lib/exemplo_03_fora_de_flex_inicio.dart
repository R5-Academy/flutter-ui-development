// exemplo_03_fora_de_flex_inicio.dart
// A armadilha clássica: usar Expanded FORA de um Row/Column/Flex.
//
// ! Este arquivo erra de propósito. E o mais traiçoeiro é justamente isto: NÃO
// ! dá tela vermelha. O app abre, a barra vermelha aparece bonitinha, e o erro
// ! sai só no console (ou na aba de erros do DevTools). Rode e leia:
// !
// !   Incorrect use of ParentDataWidget.
// !   The ParentDataWidget Expanded(flex: 1) wants to apply ParentData of type
// !   FlexParentData to a RenderObject, which has been set up to accept
// !   ParentData of incompatible type BoxParentData.
// !   Usually, this means that the Expanded widget has the wrong ancestor
// !   RenderObjectWidget. Typically, Expanded widgets are placed directly inside
// !   Flex widgets.
// !   The offending Expanded is currently placed inside a Center widget.
//
// * A última linha é a mais útil: o Flutter dedura o pai errado pelo nome.
//
// ! Expanded é um ParentDataWidget: ele só sabe conversar com um pai RenderFlex
// ! (Row/Column/Flex), para quem ele anota `flex` e `fit`. Dentro de um Center,
// ! Padding, Container, ListView — ou de um Wrap, que parece prima da Row mas
// ! não é um Flex — ninguém sabe ler essa anotação. O framework então DESCARTA a
// ! anotação e desenha a tela sem ela: apague o Expanded daqui e a tela fica
// ! pixel a pixel igual (medido). O Expanded não fez nada além do erro.
//
// (O flutter analyze passa limpo; é erro de RUNTIME, igual ao overflow.)

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaArmadilha()));

class TelaArmadilha extends StatelessWidget {
  const TelaArmadilha({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expanded fora de Flex')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // ! O Expanded está direto dentro de um Center, que não é um Flex.
        child: Center(
          child: Expanded(child: Container(color: Colors.red, height: 80)),
        ),
      ),
    );
  }
}

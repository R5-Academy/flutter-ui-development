// exemplo_05_armadilha_unbounded_inicio.dart
// A armadilha do LayoutBuilder: um contexto SEM TETO.
//
// ! Este arquivo QUEBRA ao rodar, de propósito. A mensagem, literal (medida no
// ! SDK 3.44.6, numa janela de 400px):
// !
// !   BoxConstraints forces an infinite height.
// !   These invalid constraints were provided to _RenderColoredBox's layout()
// !   function by the following function, which probably computed the invalid
// !   constraints in question:
// !     RenderConstrainedBox.performLayout (proxy_box.dart:296:14)
// !   The offending constraints were:
// !     BoxConstraints(0.0<=w<=368.0, h=Infinity)
//
// ! Uma Column dá aos filhos (não-flex) altura SEM TETO no eixo principal. Logo,
// ! um LayoutBuilder direto na Column vê `maxHeight = Infinity`. Multiplicar
// ! infinito por 0.5 continua infinito, e o Container não sabe que altura ter.
//
// ? Por que a mensagem fala de `_RenderColoredBox`? Porque `Container(color:,
// ? height:)` vira um ConstrainedBox (a altura) em volta de um ColoredBox (a cor).
// ? É o ConstrainedBox que repassa a altura infinita para o filho — e é aí que o
// ? assert do SDK dispara. Ler o nome interno na tela vermelha não assusta mais
// ? quando você sabe em que widget seu ele nasceu.
//
// * A lição: o LayoutBuilder só consegue te dar um número ÚTIL se o pai deu um
// * teto naquele eixo. Sem teto, ele devolve infinito — que é uma resposta
// * honesta, mas inútil para dimensionar.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaArmadilhaUnbounded()));

class TelaArmadilhaUnbounded extends StatelessWidget {
  const TelaArmadilhaUnbounded({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Armadilha: contexto sem teto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Uma Column dá altura SEM TETO aos filhos.'),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  color: Colors.red,
                  // ! Infinity * 0.5 = Infinity -> quebra.
                  height: constraints.maxHeight * 0.5,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// exemplo_04_directional_inicio.dart
// Ponto de partida: um respiro grande de um lado só, com EdgeInsets.only.
//
// A tela está em RTL (árabe, hebraico) — o texto lê da direita para a esquerda.
// ! Mas o respiro de 48 continua na ESQUERDA, do lado errado da leitura.
// ! left é left, sempre: EdgeInsets é FÍSICO, não conhece idioma.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: Demo()));

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        // Directionality força um idioma da direita para a esquerda. O padrão
        // do MaterialApp é LTR; aqui trocamos só para este ramo.
        child: const Directionality(
          textDirection: TextDirection.rtl,
          child: ColoredBox(
            color: Color(0xFFB2DFDB),
            child: Padding(
              padding: EdgeInsets.only(left: 48, top: 8, bottom: 8, right: 8),
              child: Text('left / right'),
            ),
          ),
        ),
      ),
    );
  }
}

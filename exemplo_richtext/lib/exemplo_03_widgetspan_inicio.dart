// exemplo_03_widgetspan_inicio.dart
// Ponto de partida: a estrela e o texto numa Row.
//
// ! A Row ESTOURA. Ela é uma linha só, e não sabe quebrar: quando a soma dos
// ! filhos passa da largura disponível, aparece a faixa amarela e preta do
// ! RenderFlex overflowed. O ícone não acompanha o fluxo do texto — ele apenas
// ! ocupa uma fatia fixa da linha, e os Text ao lado não cedem espaço.
//
// ! Palco de 320 de propósito: sem largura fixa, numa janela de desktop tudo
// ! isso cabe numa linha e o defeito não aparece. Com o palco, o estouro é o
// ! mesmo em celular, tablet ou Chrome maximizado.
//
// Queremos o ícone FLUINDO junto das letras, como se fosse um caractere.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoWidgetSpan()));

class DemoWidgetSpan extends StatelessWidget {
  const DemoWidgetSpan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SizedBox(
            width: 320,
            child: Row(
              children: [
                const Text(
                  'Avaliação média ',
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                ),
                Icon(Icons.star, size: 20, color: Colors.amber.shade700),
                const Text(
                  ' 4,8 ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  'em 1.240 avaliações',
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

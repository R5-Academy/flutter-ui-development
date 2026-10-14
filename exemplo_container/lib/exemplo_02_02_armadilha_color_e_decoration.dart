// exemplo_02_02_armadilha_color_e_decoration.dart
// A armadilha do estilo: `color` e `decoration` no mesmo Container.
//
// ! Este arquivo COMPILA e quebra ao rodar, de propósito. A mensagem, na íntegra:
// !   Cannot provide both a color and a decoration.
// !   The color argument is just a shorthand for
// !   "decoration: BoxDecoration(color: color)".
// !   To use both a color and other decoration properties, set the color in the
// !   BoxDecoration instead.
// ! A própria mensagem do Flutter entrega a correção — leia as três linhas em voz
// ! alta antes de consertar.
//
// * Detalhe que vale falar: isso é um `assert` no construtor do Container, não
// * uma checagem de layout. Ou seja, estoura no instante em que o Container é
// * criado (dentro do build), e só em modo DEBUG — em release o assert é
// * removido e o app segue pintando as duas camadas uma sobre a outra, sem aviso
// * nenhum. Mais uma razão para nunca escrever os dois.
//
// Rode, leia o erro e compare com o
// exemplo_02_01_decoracao_completo.dart.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoDecoracao()));

class DemoDecoracao extends StatelessWidget {
  const DemoDecoracao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Container(
          width: 200,
          height: 120,
          alignment: Alignment.center,
          // ! Os dois juntos: assertion em tempo de execução.
          color: Colors.white,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.indigo, width: 2),
          ),
          child: const Text('Caixa estilizada'),
        ),
      ),
    );
  }
}

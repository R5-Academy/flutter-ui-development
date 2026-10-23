// exemplo_02_height_vs_thickness_inicio.dart
// Ponto de partida: o total do pedido precisa de uma linha mais FORTE que as
// outras — é a divisão mais importante da tela.
//
// A tentativa óbvia foi aumentar o número: `Divider(height: 40)`.
//
// ! Rode. O vão em volta da linha ficou enorme... e o traço continua igualzinho
// ! ao do bloco anterior, fininho. O número subiu de 16 para 40 e a linha não
// ! engordou um pixel.
//
// ? `height` de uma linha não deveria ser a espessura dela?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: ResumoDaConta()));

class ResumoDaConta extends StatelessWidget {
  const ResumoDaConta({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conta')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _Linha(rotulo: 'Subtotal', valor: r'R$ 82,00'),
            _Linha(rotulo: 'Entrega', valor: r'R$ 7,90'),

            // ! A tentativa: engrossar a linha do total mexendo no height.
            Divider(height: 40),

            _Linha(rotulo: 'Total', valor: r'R$ 89,90'),
          ],
        ),
      ),
    );
  }
}

class _Linha extends StatelessWidget {
  const _Linha({required this.rotulo, required this.valor});

  final String rotulo;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(rotulo), Text(valor)],
      ),
    );
  }
}

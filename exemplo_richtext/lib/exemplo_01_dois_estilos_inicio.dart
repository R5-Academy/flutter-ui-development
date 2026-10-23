// exemplo_01_dois_estilos_inicio.dart
// Ponto de partida: "Total: R$ 90" num Text comum.
//
// ! O designer pediu o VALOR em negrito e verde, e o rótulo "Total:" normal.
// ! Com um `Text` só, não dá: o `style` vale para a frase inteira.
//
// A saída óbvia seria uma Row com dois Text — mas aí eles deixam de ser um
// parágrafo: não quebram linha juntos, não se alinham como texto corrido.
//
// Precisamos de vários estilos DENTRO de um único texto.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoDoisEstilos()));

class DemoDoisEstilos extends StatelessWidget {
  const DemoDoisEstilos({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          r'Total: R$ 90',
          style: TextStyle(fontSize: 22, color: Colors.black87),
        ),
      ),
    );
  }
}

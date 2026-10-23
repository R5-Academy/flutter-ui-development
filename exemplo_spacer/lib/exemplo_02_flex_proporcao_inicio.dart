// exemplo_02_flex_proporcao_inicio.dart
// Ponto de partida: três bolinhas separadas por dois Spacer iguais.
//
// * Os dois vãos ficaram do mesmo tamanho — o `flex` padrão é 1 para ambos, e
// * eles empatam na divisão da sobra.
//
// E se você quiser que um dos vãos seja maior que o outro?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: FlexProporcao()));

class FlexProporcao extends StatelessWidget {
  const FlexProporcao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spacer: flex e proporção')),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
          color: Colors.amber.withValues(alpha: 0.15),
          child: const Row(
            children: [
              _Bolinha(Colors.red),
              Spacer(),
              _Bolinha(Colors.green),
              Spacer(),
              _Bolinha(Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}

class _Bolinha extends StatelessWidget {
  const _Bolinha(this.cor);

  final Color cor;

  @override
  Widget build(BuildContext context) =>
      CircleAvatar(backgroundColor: cor, radius: 20);
}

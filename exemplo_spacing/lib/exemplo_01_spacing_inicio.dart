// exemplo_01_spacing_inicio.dart
// Ponto de partida: três caixas numa Row, coladas uma na outra.
//
// Entre a aula de Row e a de Column a gente usava SizedBox(width: 16) no
// meio dos filhos para abrir vão. Dá trabalho — e tem jeito melhor.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaSpacing()));

class TelaSpacing extends StatelessWidget {
  const TelaSpacing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spacing')),
      body: ColoredBox(
        color: Colors.grey.shade200,
        child: const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Caixa(Colors.red),
              _Caixa(Colors.green),
              _Caixa(Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}

class _Caixa extends StatelessWidget {
  const _Caixa(this.cor);

  final Color cor;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(color: cor, child: const SizedBox(width: 64, height: 64));
  }
}

// exemplo_04_main_axis_size_inicio.dart
// Ponto de partida: um chip "Pago" — ou o que deveria ser um chip.
//
// ! A pílula verde esticou de ponta a ponta e deixou de parecer um chip. O
// ! Container arredondado acompanhou a largura do Row, e o Row, por padrão
// ! (MainAxisSize.max), ocupa TODA a largura que o pai oferece.
//
// Falta dizer ao Row para abraçar só o conteúdo.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaMainAxisSize()));

class TelaMainAxisSize extends StatelessWidget {
  const TelaMainAxisSize({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('mainAxisSize')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_ChipStatus()],
        ),
      ),
    );
  }
}

class _ChipStatus extends StatelessWidget {
  const _ChipStatus();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(Icons.check_circle, size: 18, color: Colors.green),
          SizedBox(width: 6),
          Text('Pago', style: TextStyle(color: Colors.green)),
        ],
      ),
    );
  }
}

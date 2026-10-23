// exemplo_01_row_minima_inicio.dart
// Ponto de partida: uma estrela sozinha no body.
//
// O `body` do Scaffold aceita UM widget, não uma lista. E se a gente quiser três
// estrelas lado a lado? Não dá para passar três coisas aqui.
//
// É para isso que existe o Row.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaRowMinima()));

class TelaRowMinima extends StatelessWidget {
  const TelaRowMinima({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Row mínima')),
      body: const Icon(Icons.star, size: 48, color: Colors.amber),
    );
  }
}

// exemplo_01_column_minima_inicio.dart
// Ponto de partida: um bloco sozinho no body.
//
// A aula passada resolveu o "três lado a lado" com o Row. Agora queremos três
// um EMBAIXO do outro.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: ColumnMinima()));

class ColumnMinima extends StatelessWidget {
  const ColumnMinima({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Column: o mínimo')),
      body: const _Bloco(cor: Colors.red, rotulo: '1'),
    );
  }
}

// Bloquinho reutilizado nos exemplos: um retângulo colorido com um rótulo.
class _Bloco extends StatelessWidget {
  const _Bloco({required this.cor, required this.rotulo});

  final Color cor;
  final String rotulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 80,
      color: cor,
      alignment: Alignment.center,
      child: Text(
        rotulo,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

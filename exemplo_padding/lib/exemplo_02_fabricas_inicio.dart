// exemplo_02_fabricas_inicio.dart
// Ponto de partida: o EdgeInsets.all do bloco anterior, agora num "chip".
//
// O all serve para o caso mais comum — mesmo valor nos quatro lados. Mas este
// chip queria ser uma pílula: bem largo nas laterais, baixinho em cima e
// embaixo. Com o `all` não dá.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: Demo()));

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // alignment centraliza o chip sem precisar de Center (visto no Container).
      body: Container(
        alignment: Alignment.center,
        child: const ColoredBox(
          color: Color(0xFFB2DFDB),
          child: Padding(padding: EdgeInsets.all(16), child: Text('Categoria')),
        ),
      ),
    );
  }
}

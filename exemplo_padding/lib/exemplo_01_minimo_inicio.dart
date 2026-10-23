// exemplo_01_minimo_inicio.dart
// Ponto de partida: um texto solto na tela.
//
// Ele está colado no canto superior esquerdo, embaixo da barra de status.
// Sente o desconforto antes de resolver.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: Demo()));

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    // O creme é o fundo do Scaffold, então ele é a tela inteira. Assim as
    // "bordas" das quais vamos afastar o texto são as bordas da tela.
    return const Scaffold(
      backgroundColor: Color(0xFFFFF3E0),
      body: Text('Sem espaço nenhum'),
    );
  }
}

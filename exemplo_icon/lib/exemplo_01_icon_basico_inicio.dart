// exemplo_01_icon_basico_inicio.dart
// Ponto de partida: um Icon com o mínimo possível — só o IconData.
//
// * `Icons.favorite` NÃO é uma imagem: é um `IconData`, ou seja, o "código" de
// * um glifo dentro da fonte MaterialIcons (um code point + a fonte). O widget
// * `Icon` pega esse IconData e o desenha como se fosse um caractere.
//
// Sem `size` e sem `color`, ele usa o que estiver no ambiente: 24 pixels
// lógicos e preto quase opaco. Pequeno e discreto.
//
// A consequência de ser fonte, e não imagem: dá para escalar e colorir como
// texto, sem perder qualidade.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: IconBasico()));

class IconBasico extends StatelessWidget {
  const IconBasico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Icon básico')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.favorite)],
        ),
      ),
    );
  }
}

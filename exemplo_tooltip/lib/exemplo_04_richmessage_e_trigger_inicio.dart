// exemplo_04_richmessage_e_trigger_inicio.dart
// Ponto de partida: dois ícones com dica, e cada um esbarra num limite
// diferente do que a aula viu até agora.
//
// ! 1. A etiqueta de preço. A dica diz "Preço: R$ 49,90" — tudo no mesmo peso,
// !    e o que importa ali é o NÚMERO. O `message` recebe uma String, e String
// !    não tem negrito.
//
// ! 2. O "i" de informação. Esse ícone existe SÓ para explicar uma coisa: é
// !    literalmente um botão de ajuda. E, no celular, para ver a ajuda a pessoa
// !    precisa adivinhar que deve pressionar e segurar. Ninguém adivinha.
//
// Os dois têm solução, e uma delas você já conhece de outra aula.
//
// ! O problema 2 só aparece num emulador ou aparelho de toque. Com mouse, a dica
// ! abre no hover e você não sente falta de gesto nenhum.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: RichMessageETrigger()));

class RichMessageETrigger extends StatelessWidget {
  const RichMessageETrigger({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('richMessage e trigger')),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 40,
          children: [
            Tooltip(
              // ! Um estilo só para a frase inteira.
              message: r'Preço: R$ 49,90',
              child: Icon(Icons.sell, size: 44),
            ),
            Tooltip(
              // ! Um ícone de ajuda que só responde a long-press.
              message: 'O frete é calculado no fechamento do pedido',
              child: Icon(Icons.info_outline, size: 44),
            ),
          ],
        ),
      ),
    );
  }
}

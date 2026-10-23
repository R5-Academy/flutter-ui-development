// exemplo_05_iconsize_color_style_inicio.dart
// Ponto de partida: duas ações de um item de lista, nos ajustes padrão.
//
// ! O "curtir" é a ação de destaque do post — e está do mesmo tamanho de
// ! qualquer ícone de barra, perdido no cinza do tema.
//
// ! O "excluir" é irreversível — e está idêntico ao curtir. De novo o problema
// ! da aula de TextButton: consequências opostas, aparência igual.
//
// Dois ajustes de tamanho e cor resolvem o primeiro. O segundo pede mais do
// que cor de ícone: pede uma superfície.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: IconSizeColorStyle()));

class IconSizeColorStyle extends StatelessWidget {
  const IconSizeColorStyle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tamanho, cor e style')),
      body: Center(
        child: Wrap(
          spacing: 24,
          runSpacing: 24,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.thumb_up),
              tooltip: 'Curtir',
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Excluir',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

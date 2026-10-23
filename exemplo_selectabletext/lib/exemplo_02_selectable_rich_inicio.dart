// exemplo_02_selectable_rich_inicio.dart
// Ponto de partida: a frase inteira selecionável, com um estilo só.
//
// ! O valor e o cupom deveriam se destacar — e é justamente o cupom que o
// ! usuário vai querer copiar. Mas o `SelectableText` comum, como o `Text`,
// ! aceita um `style` para a frase toda.
//
// A aula anterior resolveu isso com `Text.rich`. Existe o equivalente aqui?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoSelectableRich()));

class DemoSelectableRich extends StatelessWidget {
  const DemoSelectableRich({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SelectableText.rich')),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: SelectableText(
            r'Seu total ficou em R$ 249,90 com o cupom FLUTTER10.',
            style: TextStyle(fontSize: 20, color: Colors.black87),
          ),
        ),
      ),
    );
  }
}

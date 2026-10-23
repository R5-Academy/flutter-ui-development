// exemplo_01_text_vs_selectable_inicio.dart
// Ponto de partida: o código de um pedido, num Text comum.
//
// ! Tente arrastar o mouse por cima — ou segurar o dedo, no celular. Nada
// ! acontece. O usuário NÃO consegue selecionar nem copiar esse código.
//
// É exatamente o tipo de texto que alguém vai querer colar num e-mail de
// suporte. Deixar sem cópia obriga a pessoa a transcrever à mão (e errar).

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoTextVsSelectable()));

const String codigoPedido = 'PED-2026-000482-BR';

class DemoTextVsSelectable extends StatelessWidget {
  const DemoTextVsSelectable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text vs SelectableText')),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Código (Text): $codigoPedido',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

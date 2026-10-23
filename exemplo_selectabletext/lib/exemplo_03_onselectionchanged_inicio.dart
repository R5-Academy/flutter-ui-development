// exemplo_03_onselectionchanged_inicio.dart
// Ponto de partida: um texto selecionável e um painel embaixo esperando mostrar
// o trecho marcado.
//
// ! Selecione qualquer parte da frase: o painel continua dizendo "(nada
// ! ainda)". O app não faz ideia do que o usuário marcou.
//
// Selecionar é uma interação — e toda interação pode ser observada.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoOnSelectionChanged()));

class DemoOnSelectionChanged extends StatelessWidget {
  const DemoOnSelectionChanged({super.key});

  static const _texto =
      'Flutter usa uma única base de código para Android, iOS, web e desktop.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('onSelectionChanged')),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(_texto, style: TextStyle(fontSize: 20, height: 1.5)),
            SizedBox(height: 32),
            Text(
              'Você selecionou:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            Text(
              '(nada ainda)',
              style: TextStyle(
                fontSize: 16,
                color: Colors.indigo,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

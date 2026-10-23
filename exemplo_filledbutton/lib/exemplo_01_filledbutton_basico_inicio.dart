// exemplo_01_filledbutton_basico_inicio.dart
// Ponto de partida: a tela de confirmação de um pedido, com o botão que a aula
// anterior ensinou.
//
// O `ElevatedButton` funciona. Mas olhe para ele: um retângulo claro com uma
// sombra discreta, do mesmo tamanho de qualquer outro botão.
//
// ! Essa é a ação mais importante da tela inteira — é o motivo de a tela
// ! existir. E ela não parece mais importante que nada.
//
// ? No Material 3, o destaque de um botão vem de outro lugar que não a sombra.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: FilledButtonBasico()));

class FilledButtonBasico extends StatelessWidget {
  const FilledButtonBasico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Revisar pedido')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => debugPrint('Pedido confirmado'),
              child: const Text('Confirmar pedido'),
            ),

            const SizedBox(height: 24),

            const ElevatedButton(
              onPressed: null,
              child: Text('Confirmar pedido'),
            ),
          ],
        ),
      ),
    );
  }
}

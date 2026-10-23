// exemplo_02_tonal_vs_filled_inicio.dart
// Ponto de partida: o fim do carrinho, com as duas ações que a pessoa pode
// tomar ali.
//
// ! Os dois são `FilledButton`. Os dois gritam com a mesma força.
//
// ! "Finalizar compra" é o objetivo da tela; "Adicionar mais itens" é uma volta
// ! atrás perfeitamente válida, mas secundária. Do jeito que está, a pessoa
// ! precisa LER os dois para decidir — e a regra do Material é que a ação
// ! principal deve ser reconhecível antes da leitura.
//
// Não dá para resolver isso deixando um deles feio. Precisa de um meio-termo
// entre "grita" e "quase invisível".

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TonalVsFilled()));

class TonalVsFilled extends StatelessWidget {
  const TonalVsFilled({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carrinho')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () => debugPrint('Finalizar compra'),
              child: const Text('Finalizar compra'),
            ),

            const SizedBox(height: 16),

            // ! Secundária, com o mesmo peso da principal.
            FilledButton(
              onPressed: () => debugPrint('Adicionar mais itens'),
              child: const Text('Adicionar mais itens'),
            ),
          ],
        ),
      ),
    );
  }
}

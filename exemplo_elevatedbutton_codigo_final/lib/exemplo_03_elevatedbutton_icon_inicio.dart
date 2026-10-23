// exemplo_03_elevatedbutton_icon_inicio.dart
// Ponto de partida: três botões com ícone e rótulo, montados na mão — uma `Row`
// dentro do `child`, com um `SizedBox` de respiro entre o ícone e o texto.
//
// Funciona. Mas repare no que foi preciso decidir:
//
// ! - `mainAxisSize: MainAxisSize.min`. Sem isso a Row estica e o botão ocupa a
// !   largura inteira da tela. É o erro que aparece na primeira tentativa.
// ! - `SizedBox(width: 8)`. Oito de onde? Do olho. (Coincidência feliz: 8 é
// !   mesmo o valor que o Material usa. Foi chute que acertou — o próximo não
// !   acerta, e ninguém conferiu.)
// ! - O `Text` está SOLTO dentro da Row, sem `Flexible`. Ele não tem como
// !   encolher: se o botão couber num espaço menor do que ele quer, a Row
// !   estoura na tarja amarela e preta. Medido num palco de 200 px de largura:
// !   "A RenderFlex overflowed by 10 pixels on the right". O `.icon` não
// !   estoura no mesmo palco.
//
// Três botões, três vezes a mesma Row. Existe um construtor para isso.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: BotaoComIcone()));

class BotaoComIcone extends StatelessWidget {
  const BotaoComIcone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Botão com ícone')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
              label: Text('Adicionar ao carrinho'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.download),
                  SizedBox(width: 8),
                  Text('Baixar'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Icon(Icons.lock),
              label: Text('Indisponível'),
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}

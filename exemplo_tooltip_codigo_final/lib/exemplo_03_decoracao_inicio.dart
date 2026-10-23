// exemplo_03_decoracao_inicio.dart
// Ponto de partida: a tela de um produto num app cuja identidade é roxa — a
// barra, a etiqueta de preço, tudo segue a marca.
//
// ! Passe o mouse no carrinho (ou segure o dedo). O balão que aparece é cinza
// ! escuro, quadrado, com a fonte padrão. É o visual do Material, não o do app.
//
// ! Numa tela só, ninguém morre. Mas a dica é a única coisa da interface que
// ! ignora o design system — e ela aparece justamente nos momentos em que a
// ! pessoa está prestando atenção.

import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    theme: ThemeData(colorSchemeSeed: Colors.deepPurple),
    home: const DecoracaoCustom(),
  ),
);

class DecoracaoCustom extends StatelessWidget {
  const DecoracaoCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produto'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Tooltip(
              message: 'Adicionar ao carrinho',
              preferBelow: false,
              decoration: BoxDecoration(
                color: Colors.indigo.withValues(alpha: 0.55),
                borderRadius: .circular(8),
              ),
              child: Icon(
                Icons.add_shopping_cart,
                size: 48,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 24),
            // A etiqueta de preço, roxa como o resto do app. Serve de referência
            // visual: é com ela que o balão cinza vai destoar.
            const Card(
              color: Colors.deepPurple,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  r'R$ 129,90',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

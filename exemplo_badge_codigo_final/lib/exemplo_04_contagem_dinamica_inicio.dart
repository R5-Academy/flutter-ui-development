// exemplo_04_contagem_dinamica_inicio.dart
// Ponto de partida: a vitrine de uma loja. Toque na linha de um produto e ele
// vai para o carrinho — o contador embaixo sobe, então o estado funciona.
//
// ! Só que o ícone do carrinho, lá em cima, não muda NUNCA. A pessoa adiciona
// ! três itens e a barra continua exatamente igual.
//
// ! É o pior tipo de defeito de interface: a ação funcionou, e nada confirmou.
// ! Quem está com pressa toca de novo. E de novo.
//
// O contador está no lugar errado da tela. Ele precisa estar no ícone.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaLoja()));

class TelaLoja extends StatefulWidget {
  const TelaLoja({super.key});

  @override
  State<TelaLoja> createState() => _TelaLojaState();
}

class _TelaLojaState extends State<TelaLoja> {
  static const _produtos = ['Café em grãos', 'Filtro de papel', 'Caneca'];

  // Estado de verdade: quantos itens foram para o carrinho.
  int _itens = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loja'),
        actions: [
          // ! Sempre o mesmo ícone, com ou sem itens no carrinho.
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Badge.count(
                isLabelVisible: _itens > 0,
                count: _itens,
                padding: .all(4),
                textStyle: TextStyle(fontSize: 10, fontWeight: .bold),
                child: Icon(Icons.shopping_cart, semanticLabel: 'Carrinho'),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          for (final produto in _produtos)
            // A linha inteira é o alvo do toque (o `onTap` da aula de ListTile).
            ListTile(
              title: Text(produto),
              trailing: const Icon(Icons.add),
              onTap: () => setState(() => _itens++),
            ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Itens no carrinho: $_itens'),
          ),
        ],
      ),
    );
  }
}

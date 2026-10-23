// exemplo_02_fab_extended_inicio.dart
// Ponto de partida: a tela de pedidos, com o FAB redondo do bloco anterior.
//
// ! Um "+" sozinho no canto. Adicionar o quê? Um pedido? Um item a um pedido?
// ! Um filtro?
//
// ! Numa tela de lista simples o "+" é óbvio. Aqui não: o app tem pedidos,
// ! itens e favoritos, e o mesmo símbolo poderia significar qualquer um dos
// ! três. O tooltip resolve para quem parar em cima — mas a pessoa precisaria
// ! suspeitar que vale a pena parar.
//
// Às vezes a ação principal precisa se apresentar por escrito.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: FabExtended()));

class FabExtended extends StatefulWidget {
  const FabExtended({super.key});

  @override
  State<FabExtended> createState() => _FabExtendedState();
}

class _FabExtendedState extends State<FabExtended> {
  int _pedidos = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus pedidos')),
      body: Center(
        child: Text(
          'Pedidos abertos: $_pedidos',
          style: const TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => setState(() => _pedidos++),
        tooltip: 'Criar um novo pedido',
        icon: const Icon(Icons.add),
        label: Text('Novo Pedido'),
      ),
    );
  }
}

// exemplo_06_02_fab_encaixado.dart
// A outra combinação da moldura: o FAB encaixado na barra de baixo.
// Precisa de três peças conversando — extendBody, BottomAppBar com entalhe e
// a location centerDocked do FAB.

import 'package:flutter/material.dart';

void main() => runApp(const AppFabEncaixado());

class AppFabEncaixado extends StatelessWidget {
  const AppFabEncaixado({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'FAB encaixado', home: TelaFabEncaixado());
  }
}

class TelaFabEncaixado extends StatelessWidget {
  const TelaFabEncaixado({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FAB encaixado')),
      drawer: const Drawer(child: Center(child: Text('Menu'))),
      // * extendBody deixa o body passar POR TRÁS da barra de baixo — é o que
      // * permite o entalhe do FAB na BottomAppBar aparecer direito.
      extendBody: true,
      body: const Center(child: Text('O entalhe fica no meio da barra.')),

      floatingActionButtonLocation: .centerDocked,
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          onPressed: () {},
          child: const Icon(Icons.add, size: 40),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: .spaceEvenly,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.home)),
            SizedBox(width: 44),
            IconButton(onPressed: () {}, icon: Icon(Icons.home)),
          ],
        ),
      ),

      // A BottomAppBar com entalhe é a forma M2 de encaixar o FAB.
    );
  }
}

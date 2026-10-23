// exemplo_03_fab_location_inicio.dart
// Ponto de partida: a tela ganhou uma `BottomAppBar` — a barra inferior com as
// ações de navegação.
//
// ! Olhe para o canto inferior direito. O FAB está PARADO EM CIMA da barra, sem
// ! encostar nela — medido numa tela de 400x800: o FAB vai até y=704 e a barra
// ! começa em y=720, 16 px de folga. Ele não pertence à barra; está só
// ! estacionado no canto de cima dela, como estaria em cima de qualquer coisa.
//
// ! O desenho que a gente quer é o outro: o FAB ENCAIXADO na barra, no meio, com
// ! a barra abrindo espaço para ele. E repare que não há nada de errado no
// ! código do FAB — ele está no padrão.
//
// ? Então onde se configura a posição dele? Não é no FAB — é em outro lugar do
// ? Scaffold.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: FabLocation()));

class FabLocation extends StatelessWidget {
  const FabLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Onde o FAB encaixa')),
      body: const Center(child: Text('Repare no canto inferior direito')),
      floatingActionButtonLocation: .miniCenterTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Ação principal',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.menu),
              tooltip: 'Menu',
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Buscar',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

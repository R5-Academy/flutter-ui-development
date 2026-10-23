// exemplo_01_navigationbar_inicio.dart
// Ponto de partida: a NavigationBar montada, com os três destinos no lugar.
// Rode, toque nas abas — e repare que NADA acontece.
//
// A barra não está quebrada. Ela nunca guardou estado nenhum.

import 'package:flutter/material.dart';

void main() => runApp(const AppBarraMinima());

class AppBarraMinima extends StatelessWidget {
  const AppBarraMinima({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'NavigationBar', home: TelaBarraMinima());
  }
}

class TelaBarraMinima extends StatelessWidget {
  const TelaBarraMinima({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Início')),
      body: const Center(child: Text('Aba: Início')),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (value) {},
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Início',
          ),
          NavigationDestination(icon: Icon(Icons.search), label: 'Buscar'),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

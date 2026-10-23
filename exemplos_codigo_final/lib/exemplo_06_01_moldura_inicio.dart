// exemplo_06_01_moldura_inicio.dart
// Ponto de partida: a moldura inteira da seção junta — Scaffold, AppBar,
// drawer e barra inferior, com um campo de texto no meio.
//
// Toque no campo e abra o teclado: o Scaffold encolhe o body, e a barra sobe
// junto, colada logo acima do teclado. Em muitas telas isso atrapalha.

import 'package:flutter/material.dart';

void main() => runApp(const AppMoldura());

class AppMoldura extends StatelessWidget {
  const AppMoldura({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Barra, FAB e teclado',
      home: TelaMoldura(),
    );
  }
}

class TelaMoldura extends StatefulWidget {
  const TelaMoldura({super.key});

  @override
  State<TelaMoldura> createState() => _TelaMolduraState();
}

class _TelaMolduraState extends State<TelaMoldura> {
  int _indice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Moldura completa')),
      drawer: const Drawer(child: Center(child: Text('Menu'))),
      body: const Center(
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Toque para abrir o teclado',
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indice,
        onDestinationSelected: (int novoIndice) =>
            setState(() => _indice = novoIndice),
        destinations: const [
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

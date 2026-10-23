// exemplo_04_01_bottomnavigationbar_inicio.dart
// Ponto de partida: a barra do Material 2 com TRÊS itens. É o que você vai
// encontrar em código antigo e em quase todo tutorial da internet.
//
// * O dicionário de tradução do M3 para o M2:
// * destinations -> items · selectedIndex -> currentIndex
// * onDestinationSelected -> onTap · selectedIcon -> activeIcon
//
// Assim, com três itens, funciona sem surpresa. O problema começa no quarto:
// veja o exemplo_04_02_bottomnavigationbar_armadilha.dart.

import 'package:flutter/material.dart';

void main() => runApp(const AppBarraM2());

class AppBarraM2 extends StatelessWidget {
  const AppBarraM2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'BottomNavigationBar (M2)', home: TelaM2());
  }
}

class TelaM2 extends StatefulWidget {
  const TelaM2({super.key});

  @override
  State<TelaM2> createState() => _TelaM2State();
}

class _TelaM2State extends State<TelaM2> {
  int _indice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Material 2')),
      body: Center(child: Text('Item ${_indice + 1} de 3')),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            // No M2 o ícone ativo se chama activeIcon (no M3 é selectedIcon).
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Início',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Ajustes',
            backgroundColor: Colors.green,
          ),
        ],
        currentIndex: _indice,
        onTap: (int novoIndice) => setState(() => _indice = novoIndice),
        type: .fixed,
      ),
    );
  }
}

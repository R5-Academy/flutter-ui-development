// exemplo_06_navigation_drawer_inicio.dart
// Ponto de partida: o menu montado na mão, como no bloco 02 — ListTile por
// ListTile, com o `selected` controlado por nós.
// Funciona. A pergunta é: dá para o Material 3 fazer isso por você?

import 'package:flutter/material.dart';

void main() => runApp(const AppNavigationDrawer());

class AppNavigationDrawer extends StatelessWidget {
  const AppNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'NavigationDrawer (M3)',
      home: TelaNavigationDrawer(),
    );
  }
}

class TelaNavigationDrawer extends StatefulWidget {
  const TelaNavigationDrawer({super.key});

  @override
  State<TelaNavigationDrawer> createState() => _TelaNavigationDrawerState();
}

class _TelaNavigationDrawerState extends State<TelaNavigationDrawer> {
  static const List<String> _secoes = ['Início', 'Receitas', 'Favoritas'];
  static const List<IconData> _icones = [
    Icons.home,
    Icons.restaurant_menu,
    Icons.favorite,
  ];

  int _indice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_secoes[_indice])),
      drawer: Drawer(
        child: Builder(
          builder: (context) {
            return NavigationDrawer(
              onDestinationSelected: (value) {
                setState(() {
                  _indice = value;
                });
                Scaffold.of(context).closeDrawer();
              },
              selectedIndex: _indice,
              children: [
                const DrawerHeader(child: Center(child: Text('Sabor Caseiro'))),
                for (int i = 0; i < _secoes.length; i++)
                  NavigationDrawerDestination(
                    icon: Icon(_icones[i]),
                    label: Text(_secoes[i]),
                    selectedIcon: Icon(_icones[i]),
                  ),
              ],
            );
          },
        ),
      ),
      body: Center(child: Text('Seção atual: ${_secoes[_indice]}')),
    );
  }
}

// main.dart
// Índice do projeto de exemplos da aula de Drawer.
// Cada exemplo é um app independente: rode com `flutter run -t lib/....dart`.
//
// Os arquivos vêm em pares: o `_inicio` é o ponto de partida da explicação e o
// `_completo` é onde a gente chega escrevendo o código durante a aula.

import 'package:flutter/material.dart';

void main() => runApp(const AppIndice());

class AppIndice extends StatelessWidget {
  const AppIndice({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Exemplos — Drawer', home: TelaIndice());
  }
}

class TelaIndice extends StatelessWidget {
  const TelaIndice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exemplos — Drawer')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Text(
          'Rode cada exemplo por conta própria:\n\n'
          '1. o menu mínimo\n'
          '   -t lib/exemplo_01_drawer_minimo_inicio.dart\n'
          '   -t lib/exemplo_01_drawer_minimo_completo.dart\n\n'
          '2. o menu com itens\n'
          '   -t lib/exemplo_02_menu_inicio.dart\n'
          '   -t lib/exemplo_02_menu_completo.dart\n\n'
          '3. abrir e fechar por código\n'
          '   -t lib/exemplo_03_01_abrir_inicio.dart\n'
          '   -t lib/exemplo_03_01_abrir_completo.dart\n'
          '   -t lib/exemplo_03_02_abrir_globalkey.dart\n\n'
          '4. o endDrawer\n'
          '   -t lib/exemplo_04_enddrawer_inicio.dart\n'
          '   -t lib/exemplo_04_enddrawer_completo.dart\n\n'
          '5. o tema dos menus\n'
          '   -t lib/exemplo_05_tema_inicio.dart\n'
          '   -t lib/exemplo_05_tema_completo.dart\n\n'
          '6. o NavigationDrawer do M3\n'
          '   -t lib/exemplo_06_navigation_drawer_inicio.dart\n'
          '   -t lib/exemplo_06_navigation_drawer_completo.dart',
        ),
      ),
    );
  }
}

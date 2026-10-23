// exemplo_05_tema_inicio.dart
// Ponto de partida: o menu nos padrões do Material 3 — 304 de largura,
// surfaceContainerLow de fundo e 16 de raio no canto de dentro.
// Nenhuma palavra sobre aparência em lugar nenhum.

import 'package:flutter/material.dart';

void main() => runApp(const AppTemaDrawer());

class AppTemaDrawer extends StatelessWidget {
  const AppTemaDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawer e tema',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        drawerTheme: DrawerThemeData(
          width: 260,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.horizontal(
              end: Radius.circular(50),
            ),
          ),
        ),
      ),
      home: const TelaTema(),
    );
  }
}

class TelaTema extends StatelessWidget {
  const TelaTema({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sabor Caseiro')),
      drawerScrimColor: Colors.black87,
      drawer: const Drawer(child: Center(child: Text('Menu'))),
      body: const Center(
        child: Text(
          'Padrão do Material 3:\n304 de largura e canto de 16.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

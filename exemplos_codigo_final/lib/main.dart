// main.dart
// Índice do projeto de exemplos da aula de barras de navegação inferior.
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
    return const MaterialApp(
      title: 'Exemplos — Barra inferior',
      home: TelaIndice(),
    );
  }
}

class TelaIndice extends StatelessWidget {
  const TelaIndice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exemplos — Barra inferior')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Text(
          'Rode cada exemplo por conta própria:\n\n'
          '1. a NavigationBar mínima\n'
          '   -t lib/exemplo_01_navigationbar_inicio.dart\n'
          '   -t lib/exemplo_01_navigationbar_completo.dart\n\n'
          '2. o estado das abas (IndexedStack)\n'
          '   -t lib/exemplo_02_estado_das_abas_inicio.dart\n'
          '   -t lib/exemplo_02_estado_das_abas_completo.dart\n\n'
          '3. rótulos e ícones dos destinos\n'
          '   -t lib/exemplo_03_destinos_inicio.dart\n'
          '   -t lib/exemplo_03_destinos_completo.dart\n\n'
          '4. o BottomNavigationBar do M2\n'
          '   -t lib/exemplo_04_01_bottomnavigationbar_inicio.dart\n'
          '   -t lib/exemplo_04_02_bottomnavigationbar_armadilha.dart\n'
          '   -t lib/exemplo_04_01_bottomnavigationbar_completo.dart\n\n'
          '5. o tema da barra\n'
          '   -t lib/exemplo_05_tema_inicio.dart\n'
          '   -t lib/exemplo_05_tema_completo.dart\n\n'
          '6. a moldura inteira\n'
          '   -t lib/exemplo_06_01_moldura_inicio.dart\n'
          '   -t lib/exemplo_06_01_moldura_completo.dart\n'
          '   -t lib/exemplo_06_02_fab_encaixado.dart',
        ),
      ),
    );
  }
}

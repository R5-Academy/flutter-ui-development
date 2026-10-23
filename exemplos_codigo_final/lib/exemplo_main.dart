// exemplo_main.dart
// Índice do projeto de exemplos da aula de Scaffold.
// Cada exemplo é um app independente: rode com `flutter run -t lib/exemplo_NN_....dart`.

import 'package:flutter/material.dart';

void main() => runApp(const AppIndice());

class AppIndice extends StatelessWidget {
  const AppIndice({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Exemplos — Scaffold', home: TelaIndice());
  }
}

class TelaIndice extends StatelessWidget {
  const TelaIndice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exemplos — Scaffold')),
      body: const Center(
        child: Text(
          'Rode cada exemplo por conta própria:\n\n'
          'flutter run -t lib/exemplo_01_sem_scaffold.dart\n'
          'flutter run -t lib/exemplo_02_scaffold_minimo.dart\n'
          'flutter run -t lib/exemplo_03_anatomia_dos_slots.dart\n'
          'flutter run -t lib/exemplo_04_area_segura.dart\n'
          'flutter run -t lib/exemplo_05_teclado_resize.dart\n'
          'flutter run -t lib/exemplo_06_scaffold_of_armadilha.dart',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

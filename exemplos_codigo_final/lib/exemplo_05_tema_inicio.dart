// exemplo_05_tema_inicio.dart
// Ponto de partida: a barra nos padrões do Material 3 — 80 de altura,
// indicador secondaryContainer e rótulos sempre visíveis.
// Nenhuma palavra sobre aparência em lugar nenhum.

import 'package:flutter/material.dart';

void main() => runApp(const AppTemaBarra());

class AppTemaBarra extends StatelessWidget {
  const AppTemaBarra({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cores = .fromSeed(seedColor: Colors.teal);

    return MaterialApp(
      title: 'Barra e tema',
      theme: ThemeData(
        colorScheme: cores,
        navigationBarTheme: NavigationBarThemeData(
          height: 64,
          indicatorColor: Colors.red,
        ),
      ),
      home: const TelaTema(),
    );
  }
}

class TelaTema extends StatefulWidget {
  const TelaTema({super.key});

  @override
  State<TelaTema> createState() => _TelaTemaState();
}

class _TelaTemaState extends State<TelaTema> {
  int _indice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sabor Caseiro')),
      body: const Center(
        child: Text(
          'Padrão do Material 3: 80 de altura,\n'
          'indicador secondaryContainer\ne rótulos sempre visíveis.',
          textAlign: TextAlign.center,
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

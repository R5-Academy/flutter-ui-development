// exemplo_03_destinos_inicio.dart
// Ponto de partida: os destinos no mínimo — um ícone e um rótulo cada.
// Funciona, mas falta acabamento: o ícone não muda ao ser selecionado, não há
// tooltip e todo destino está sempre disponível.

import 'package:flutter/material.dart';

void main() => runApp(const AppAjustes());

class AppAjustes extends StatelessWidget {
  const AppAjustes({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Rótulos e ícones', home: TelaAjustes());
  }
}

class TelaAjustes extends StatefulWidget {
  const TelaAjustes({super.key});

  @override
  State<TelaAjustes> createState() => _TelaAjustesState();
}

class _TelaAjustesState extends State<TelaAjustes> {
  int _indice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rótulos e ícones')),
      body: const Center(
        child: Text(
          'labelBehavior:\nalwaysShow (o padrão)',
          textAlign: TextAlign.center,
        ),
      ),

      bottomNavigationBar: NavigationBar(
        labelBehavior: .onlyShowSelected,
        selectedIndex: _indice,
        onDestinationSelected: (int novoIndice) =>
            setState(() => _indice = novoIndice),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoritas',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
          NavigationDestination(
            icon: Icon(Icons.workspace_premium_outlined),
            label: 'Premium',
          ),
        ],
      ),
    );
  }
}

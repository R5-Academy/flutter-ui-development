// exemplo_04_02_bottomnavigationbar_armadilha.dart
// A armadilha clássica: o MESMO código do início, com um quarto item.
// Rode e veja a barra sumir na frente da turma.
//
// ! Sem type, a barra decide sozinha: até 3 itens fica fixed, com 4 ou mais
// ! vira shifting — e no shifting, sem cor por item, os ícones ficam quase
// ! brancos sobre fundo branco e os rótulos inativos somem.
//
// A correção está no exemplo_04_01_bottomnavigationbar_completo.dart.

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
      body: Center(
        child: Text(
          'Item ${_indice + 1} de 4\n\n'
          'Com 4 itens e sem type, ele virou shifting:\n'
          'os ícones ficaram quase brancos e os rótulos\n'
          'inativos sumiram.',
          textAlign: TextAlign.center,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // type: .fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Ajustes',
          ),
        ],
        currentIndex: _indice,
        onTap: (int novoIndice) => setState(() => _indice = novoIndice),
      ),
    );
  }
}

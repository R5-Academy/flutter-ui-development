// exemplo_02_estado_das_abas_inicio.dart
// Ponto de partida: o jeito mais óbvio de trocar o conteúdo — o body vira a
// aba do índice atual.
//
// Rode e faça o teste com a turma: clique umas cinco vezes no contador da aba
// Início, vá para Perfil e volte. O contador ZEROU.
// A aba anterior foi destruída, e o estado dela foi junto.

import 'package:flutter/material.dart';

void main() => runApp(const AppEstadoDasAbas());

class AppEstadoDasAbas extends StatelessWidget {
  const AppEstadoDasAbas({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Estado das abas', home: TelaAbas());
  }
}

class TelaAbas extends StatefulWidget {
  const TelaAbas({super.key});

  @override
  State<TelaAbas> createState() => _TelaAbasState();
}

class _TelaAbasState extends State<TelaAbas> {
  static const List<String> _abas = ['Início', 'Buscar', 'Perfil'];

  int _indice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_abas[_indice])),
      // Só existe a aba atual. Ao sair, ela é descartada — e com ela o estado
      // (o que o usuário digitou, o quanto ele rolou).
      body: IndexedStack(
        index: _indice,
        children: [
          _Contador(key: ValueKey(0), nome: _abas[0]),
          _Contador(key: ValueKey(1), nome: _abas[1]),
          _Contador(key: ValueKey(2), nome: _abas[2]),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indice,
        onDestinationSelected: (int novoIndice) =>
            setState(() => _indice = novoIndice),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(icon: Icon(Icons.search), label: 'Buscar'),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

// Uma aba qualquer, com estado próprio: quantas vezes o botão foi tocado.
class _Contador extends StatefulWidget {
  const _Contador({super.key, required this.nome});

  final String nome;

  @override
  State<_Contador> createState() => _ContadorState();
}

class _ContadorState extends State<_Contador> {
  int _cliques = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => setState(() => _cliques++),
        child: Text('${widget.nome}: $_cliques cliques'),
      ),
    );
  }
}

// exemplo_03_anatomia_dos_slots.dart
// Demonstra: os slots da moldura preenchidos, e o que acontece quando um some.
// Novo em relação ao 02: appBar, drawer, endDrawer, bottomNavigationBar,
// floatingActionButton, bottomSheet e persistentFooterButtons no mesmo Scaffold.

import 'package:flutter/material.dart';

void main() => runApp(const AppAnatomia());

class AppAnatomia extends StatelessWidget {
  const AppAnatomia({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Anatomia do Scaffold',
      home: TelaAnatomia(),
    );
  }
}

class TelaAnatomia extends StatefulWidget {
  const TelaAnatomia({super.key});

  @override
  State<TelaAnatomia> createState() => _TelaAnatomiaState();
}

class _TelaAnatomiaState extends State<TelaAnatomia> {
  // Cada flag liga/desliga um slot para a turma ver o body crescer e encolher.
  bool _comAppBar = true;
  bool _comBarraInferior = true;
  bool _comFab = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // * appBar é PreferredSizeWidget, não Widget: o Scaffold precisa saber a
      // * altura da barra ANTES de medir o resto da tela.
      appBar: _comAppBar ? AppBar(title: const Text('Anatomia')) : null,

      // O ícone de menu (as três linhas) aparece sozinho na AppBar porque existe
      // um drawer aqui embaixo. Quem pergunta isso ao Scaffold é a própria AppBar.
      drawer: const Drawer(
        child: Center(child: Text('drawer (borda inicial)')),
      ),
      endDrawer: const Drawer(
        child: Center(child: Text('endDrawer (borda final)')),
      ),

      // * O body fica com o espaço que sobra entre a appBar e as barras de baixo.
      body: Center(
        child: Text(
          'body\n\n'
          'appBar: ${_comAppBar ? "ligada" : "desligada"}\n'
          'bottomNavigationBar: ${_comBarraInferior ? "ligada" : "desligada"}\n'
          'floatingActionButton: ${_comFab ? "ligado" : "desligado"}\n\n'
          'Arraste da borda esquerda ou direita\npara abrir os drawers.',
          textAlign: TextAlign.center,
        ),
      ),

      floatingActionButton: _comFab
          ? FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add))
          : null,
      // Sem informar a location, o padrão é FloatingActionButtonLocation.endFloat.
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      // Os botões de controle da demonstração moram num slot do próprio Scaffold:
      // persistentFooterButtons fica acima da barra inferior e abaixo do body.
      persistentFooterButtons: [
        TextButton(
          onPressed: () => setState(() => _comAppBar = !_comAppBar),
          child: const Text('appBar'),
        ),
        TextButton(
          onPressed: () =>
              setState(() => _comBarraInferior = !_comBarraInferior),
          child: const Text('barra'),
        ),
        TextButton(
          onPressed: () => setState(() => _comFab = !_comFab),
          child: const Text('FAB'),
        ),
      ],

      // bottomSheet é a folha PERSISTENTE: fica sempre visível, colada na base do
      // conteúdo. Não confunda com showModalBottomSheet, que é uma rota modal.
      bottomSheet: const SizedBox(
        height: 48,
        child: Center(child: Text('bottomSheet (persistente)')),
      ),

      bottomNavigationBar: _comBarraInferior
          ? NavigationBar(
              selectedIndex: 0,
              onDestinationSelected: (int indice) {},
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Início'),
                NavigationDestination(
                  icon: Icon(Icons.person),
                  label: 'Perfil',
                ),
              ],
            )
          : null,
    );
  }
}

// exemplo_02_menu_inicio.dart
// Ponto de partida: o menu do bloco anterior — existe, abre, e está vazio.
// A partir daqui montamos o conteúdo dele.

import 'package:flutter/material.dart';

void main() => runApp(const AppMenu());

class AppMenu extends StatelessWidget {
  const AppMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Menu com itens', home: TelaMenu());
  }
}

class TelaMenu extends StatefulWidget {
  const TelaMenu({super.key});

  @override
  State<TelaMenu> createState() => _TelaMenuState();
}

class _TelaMenuState extends State<TelaMenu> {
  var _secao = 'Início';

  void _selecionar(String secao) => setState(() {
    _secao = secao;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Início')),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Center(child: Text('Sabor Caseiro')),
            ),
            _ItemMenu(
              icone: Icons.home,
              rotulo: 'Início',
              selecionado: _secao == 'Início',
              aoSelecionar: _selecionar,
            ),
            _ItemMenu(
              icone: Icons.restaurant_menu,
              rotulo: 'Receitas',
              selecionado: _secao == 'Receitas',
              aoSelecionar: _selecionar,
            ),
            Divider(),
            _ItemMenu(
              icone: Icons.settings,
              rotulo: 'Ajustes',
              selecionado: _secao == 'Ajustes',
              aoSelecionar: _selecionar,
            ),
          ],
        ),
      ),
      body: Center(child: Text('Seção atual: $_secao')),
    );
  }
}

class _ItemMenu extends StatelessWidget {
  final IconData _icone;
  final String _rotulo;
  final bool _selecionado;
  final ValueChanged<String> _aoSelecionar;

  const _ItemMenu({
    super.key,
    required this._icone,
    required this._rotulo,
    required this._selecionado,
    required this._aoSelecionar,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_rotulo),
      selected: _selecionado,
      leading: Icon(_icone),
      onTap: () {
        _aoSelecionar(_rotulo);
        Scaffold.of(context).closeDrawer();
      },
    );
  }
}

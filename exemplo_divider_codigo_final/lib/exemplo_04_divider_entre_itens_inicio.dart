// exemplo_04_divider_entre_itens_inicio.dart
// Ponto de partida: o menu do app, quatro itens numa Column.
//
// ! Os quatro estão colados. Sem nada entre eles, a lista vira um bloco só de
// ! texto e ícone, e o olho precisa contar as linhas para saber quantas opções
// ! existem.
//
// É o caso mais comum de Divider que você vai escrever na vida — e ele tem um
// detalhe de alinhamento que separa a lista bem-feita da apressada.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: MenuComDivisorias()));

class MenuComDivisorias extends StatelessWidget {
  const MenuComDivisorias({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(leading: Icon(Icons.person), title: Text('Perfil')),
            Divider(height: 1, indent: 16, endIndent: 16),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notificações'),
            ),
            Divider(height: 1, indent: 16, endIndent: 16),
            ListTile(leading: Icon(Icons.lock), title: Text('Privacidade')),
            Divider(height: 1, indent: 16, endIndent: 16),
            ListTile(leading: Icon(Icons.help_outline), title: Text('Ajuda')),
          ],
        ),
      ),
    );
  }
}

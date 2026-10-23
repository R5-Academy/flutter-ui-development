// exemplo_02_ontap_inicio.dart
// Ponto de partida: a linha de Wi-Fi da tela de configurações, já com o
// ListTile e os quatro encaixes.
//
// ! Repare no `trailing`: uma seta apontando para a direita. Essa seta é uma
// ! PROMESSA — ela diz "toque aqui para abrir". Toque: não acontece nada. Nem
// ! um efeito visual.
//
// Uma linha que parece clicável e não é frustra mais do que uma linha que nem
// parece.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ListTileOnTap()));

class ListTileOnTap extends StatelessWidget {
  const ListTileOnTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListTile com onTap')),
      body: Align(
        alignment: Alignment.topCenter,
        child: ListTile(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Abriu as configurações do WI-FI')),
            );
          },
          onLongPress: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Toque Longo: Abriu as configurações do WI-FI'),
              ),
            );
          },
          leading: Icon(Icons.wifi),
          title: Text('Wi-Fi'),
          subtitle: Text('Academia_5G'),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}

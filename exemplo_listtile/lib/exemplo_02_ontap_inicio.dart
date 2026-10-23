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

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: ListTileOnTap()));

class ListTileOnTap extends StatelessWidget {
  const ListTileOnTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListTile com onTap')),
      body: const Align(
        alignment: Alignment.topCenter,
        child: ListTile(
          leading: Icon(Icons.wifi),
          title: Text('Wi-Fi'),
          subtitle: Text('Academia_5G'),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}

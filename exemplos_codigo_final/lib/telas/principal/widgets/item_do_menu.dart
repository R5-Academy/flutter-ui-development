import 'package:flutter/material.dart';

// * Widget extraído de propósito: assim o `context` do build já nasce ABAIXO do
// * Scaffold, e o Scaffold.of(context) daqui encontra o que precisa para fechar
// * o menu. Com o context do build da TelaPrincipal isso quebraria.
class ItemDoMenu extends StatelessWidget {
  const ItemDoMenu({
    super.key,
    required this.icone,
    required this.rotulo,
    required this.aoTocar,
    this.selecionado = false,
  });

  final IconData icone;
  final String rotulo;
  final VoidCallback aoTocar;
  final bool selecionado;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: ListTile(
        leading: Icon(icone),
        title: Text(rotulo),
        selected: selecionado,
        onTap: () {
          // * Fecha o menu de forma explícita e segura: se ele já estiver
          // * fechado, não acontece nada.
          // ! Navigator.pop(context) também fecha, mas derruba a tela inteira
          // ! quando o menu já está fechado.
          Scaffold.of(context).closeDrawer();
          aoTocar();
        },
      ),
    );
  }
}

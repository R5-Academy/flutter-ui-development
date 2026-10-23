import 'package:flutter/material.dart';

import '../../../modelos/destino.dart';
import 'cabecalho_do_menu.dart';
import 'item_do_menu.dart';

// * A gaveta do app: cabeçalho + os destinos principais + as opções que não
// * merecem um lugar na barra de baixo. Ela também não guarda estado: recebe o
// * destino ativo e avisa qual foi tocado.
class MenuLateral extends StatelessWidget {
  const MenuLateral({
    super.key,
    required this.destinoAtivo,
    required this.aoSelecionarDestino,
  });

  final Destino destinoAtivo;
  final ValueChanged<Destino> aoSelecionarDestino;

  void _avisar(BuildContext context, String opcao) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$opcao ainda não foi implementado')));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // * A receita da aula: ListView com padding zero. O ListView faz o menu
      // * rolar quando tem item demais, e o padding zero deixa o cabeçalho
      // * encostar no topo da tela, por trás da barra de status.
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const CabecalhoDoMenu(nome: 'Usuário', email: 'usuario@email.com'),
          const SizedBox(height: 8),
          for (final Destino destino in Destino.values)
            ItemDoMenu(
              icone: destino.iconeAtivo,
              rotulo: destino.rotulo,
              selecionado: destino == destinoAtivo,
              aoTocar: () => aoSelecionarDestino(destino),
            ),
          ItemDoMenu(
            icone: Icons.settings,
            rotulo: 'Configurações',
            aoTocar: () => _avisar(context, 'Configurações'),
          ),
          ItemDoMenu(
            icone: Icons.help_outline,
            rotulo: 'Ajuda',
            aoTocar: () => _avisar(context, 'Ajuda'),
          ),
          const Divider(indent: 12, endIndent: 12),
          ItemDoMenu(
            icone: Icons.logout,
            rotulo: 'Sair',
            aoTocar: () => _avisar(context, 'Sair'),
          ),
        ],
      ),
    );
  }
}

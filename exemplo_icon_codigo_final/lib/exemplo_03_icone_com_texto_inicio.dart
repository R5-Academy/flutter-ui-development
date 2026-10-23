// exemplo_03_icone_com_texto_inicio.dart
// Ponto de partida: uma lista de itens de menu, só com os rótulos.
//
// Funciona, mas é uma parede de texto: o olho não encontra nada rápido. Todo
// menu de app tem um ícone à esquerda de cada item.
//
// Repare também no que esta tela NÃO consegue dizer: que o item "Privacidade"
// está com uma pendência. Não há texto para isso — e é justamente aí que a
// acessibilidade do ícone deixa de ser detalhe.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: MenuLista()));

class MenuLista extends StatelessWidget {
  const MenuLista({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Itens de menu')),
      body: const Column(
        children: [
          _ItemMenu(texto: 'Meu perfil', icone: Icons.person_outline),
          _ItemMenu(texto: 'Notificações', icone: Icons.notifications_outlined),
          _ItemMenu(
            texto: 'Privacidade',
            icone: Icons.lock_outline,
            alerta: 'Requer Atenção',
          ),
          _ItemMenu(texto: 'Ajuda', icone: Icons.help_outline),
        ],
      ),
    );
  }
}

class _ItemMenu extends StatelessWidget {
  final IconData icone;
  final String texto;
  final String? alerta;

  const _ItemMenu({required this.texto, required this.icone, this.alerta});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Icon(icone, size: 24, color: Colors.blueGrey),
          SizedBox(width: 16),
          Text(texto, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          if (alerta != null) ...[
            Icon(
              Icons.error_outline,
              color: Colors.orange,
              semanticLabel: alerta,
            ),
            SizedBox(width: 8),
          ],

          Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}

// exemplo_04_icone_com_texto_inicio.dart
// Ponto de partida: uma lista de itens de menu, só com os rótulos.
//
// Funciona, mas é uma parede de texto: o olho não encontra nada rápido. Todo
// menu de app tem um ícone à esquerda de cada item.
//
// Repare também no que esta tela NÃO consegue dizer: que o item "Privacidade"
// está com uma pendência. Não há texto para isso — e é justamente aí que a
// acessibilidade do ícone deixa de ser detalhe.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: MenuLista()));

class MenuLista extends StatelessWidget {
  const MenuLista({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Itens de menu')),
      body: const Column(
        children: [
          _ItemMenu(texto: 'Meu perfil'),
          _ItemMenu(texto: 'Notificações'),
          _ItemMenu(texto: 'Privacidade'),
          _ItemMenu(texto: 'Ajuda'),
        ],
      ),
    );
  }
}

class _ItemMenu extends StatelessWidget {
  const _ItemMenu({required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Text(texto, style: const TextStyle(fontSize: 16)),
          const Spacer(),
        ],
      ),
    );
  }
}

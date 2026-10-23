// exemplo_06_linha_menu_inicio.dart
// Ponto de partida: uma linha de menu de configurações, com todos os quatro
// elementos no lugar — ícone, título, valor e seta.
//
// ! Só que está tudo amontoado à esquerda. Numa tela de configurações de
// ! verdade, o valor e a seta ficam na ponta direita.
//
// Os três controles da aula resolvem isso sem um pixel de cálculo.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaMenu()));

class TelaMenu extends StatelessWidget {
  const TelaMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        children: [
          _LinhaMenu(
            icone: Icons.notifications,
            titulo: 'Notificações',
            valor: 'Ativas',
          ),
          _LinhaMenu(
            icone: Icons.language,
            titulo: 'Idioma',
            valor: 'Português',
          ),
          _LinhaMenu(icone: Icons.dark_mode, titulo: 'Tema', valor: 'Escuro'),
        ],
      ),
    );
  }
}

class _LinhaMenu extends StatelessWidget {
  const _LinhaMenu({
    required this.icone,
    required this.titulo,
    required this.valor,
  });

  final IconData icone;
  final String titulo;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          Icon(icone, color: Colors.indigo),
          const SizedBox(width: 12),
          Text(titulo, style: const TextStyle(fontSize: 16)),
          Text(valor, style: const TextStyle(color: Colors.grey)),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}

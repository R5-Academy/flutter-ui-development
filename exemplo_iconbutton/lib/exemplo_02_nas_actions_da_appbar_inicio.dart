// exemplo_02_nas_actions_da_appbar_inicio.dart
// Ponto de partida: a AppBar da tela de produto, com as três ações no canto
// direito — o lugar onde todo app coloca os botões de ícone.
//
// ! Passe o mouse por cima (ou segure o dedo). Nada. Três símbolos e nenhum
// ! nome: a lupa até dá para adivinhar, mas os três pontinhos?
//
// ! É o mesmo problema da aula de Tooltip, e a solução também seria envolver
// ! cada um com `Tooltip`. Só que aqui existe um caminho mais curto — e é o
// ! motivo de esses botões aparecerem tanto na AppBar.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: ActionsDaAppBar()));

class ActionsDaAppBar extends StatelessWidget {
  const ActionsDaAppBar({super.key});

  void _aviso(BuildContext context, String texto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(texto), duration: const Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhe do produto'),
        // actions: a lista de botões à direita do título.
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _aviso(context, 'Buscar'),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _aviso(context, 'Compartilhar'),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _aviso(context, 'Mais opções'),
          ),
        ],
      ),
      body: const Center(child: Text('O que faz cada ícone lá em cima?')),
    );
  }
}

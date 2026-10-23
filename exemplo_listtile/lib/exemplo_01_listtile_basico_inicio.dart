// exemplo_01_listtile_basico_inicio.dart
// Ponto de partida: a linha de um contato — avatar, nome, cargo e a setinha —
// montada com o que a gente já sabe: Row, Column, Padding, SizedBox.
//
// ! Funciona. Mas conte o que foi preciso decidir na mão: o padding de 16, o
// ! respiro de 16 entre o ícone e o texto, os 4 entre título e subtítulo, o
// ! tamanho e a cor do subtítulo, o Expanded para o texto não estourar.
//
// ! Nenhum desses números veio do Material. Foram chutados — e na próxima tela
// ! serão outros. Aí cada lista do app tem um respiro diferente.
//
// Esse miolo de linha é tão comum que o Material já entrega pronto.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: ListTileBasico()));

class ListTileBasico extends StatelessWidget {
  const ListTileBasico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Linha de contato')),
      body: const Align(alignment: Alignment.topCenter, child: _LinhaNaMao()),
    );
  }
}

class _LinhaNaMao extends StatelessWidget {
  const _LinhaNaMao();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.person),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ana Souza', style: TextStyle(fontSize: 16)),
                SizedBox(height: 4),
                Text(
                  'Product Designer',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}

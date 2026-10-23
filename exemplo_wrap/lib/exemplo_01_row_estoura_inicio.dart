// exemplo_01_row_estoura_inicio.dart
// Ponto de partida: sete chips de filtro numa Row, dentro de uma caixa de 320.
//
// ! ESTOURA de propósito. A Row tenta caber todos os filhos numa ÚNICA linha.
// ! Como a soma das larguras passa da largura da caixa, ela não tem para onde
// ! empurrar: aparecem as listras na direita e, no console, a linha
// ! "A RenderFlex overflowed by N pixels on the right."
//
// A Row não sabe quebrar linha. Precisamos de outro widget.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoRowVsWrap()));

const List<String> tags = [
  'Flutter',
  'Dart',
  'Widgets',
  'Layout',
  'Estado',
  'Animações',
  'Testes',
];

class DemoRowVsWrap extends StatelessWidget {
  const DemoRowVsWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Row estoura x Wrap quebra')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Row (uma linha só):'),
            const SizedBox(height: 8),
            // * O palco tem largura FIXA de 320 de propósito. Overflow depende do
            // * espaço disponível: numa janela larga esses sete chips caberiam
            // * numa linha e não haveria nada para mostrar. Com a caixa fixa, o
            // * estouro acontece em qualquer device e em qualquer janela.
            Container(
              width: 320,
              color: Colors.amber.withValues(alpha: 0.15),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [for (final String tag in tags) _Chip(texto: tag)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Um "chip" feito na mão com Container estilizado (ainda não vimos o Chip do
// Material). É só uma caixa arredondada com um texto e um respiro interno.
class _Chip extends StatelessWidget {
  const _Chip({required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.indigo.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(texto),
    );
  }
}

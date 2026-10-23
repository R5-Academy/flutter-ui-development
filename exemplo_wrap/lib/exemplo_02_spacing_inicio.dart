// exemplo_02_spacing_inicio.dart
// Ponto de partida: o Wrap do bloco anterior, com mais tags.
//
// ! Funciona — não estoura — mas os chips estão todos colados, tanto na
// ! horizontal quanto na vertical. Falta ar.
//
// O Wrap tem DOIS parâmetros de espaçamento, e eles não são a mesma coisa.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoSpacing()));

const List<String> tags = [
  'Flutter',
  'Dart',
  'Widgets',
  'Layout',
  'Estado',
  'Animações',
  'Testes',
  'Navegação',
  'Firebase',
];

class DemoSpacing extends StatelessWidget {
  const DemoSpacing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('spacing x runSpacing')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // * Palco de largura fixa: garante que o Wrap quebre em várias linhas em
        // * qualquer janela — sem quebra não há runSpacing para observar.
        child: Container(
          width: 320,
          color: Colors.amber.withValues(alpha: 0.15),
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [for (final String tag in tags) _Chip(texto: tag)],
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.teal.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(texto),
    );
  }
}

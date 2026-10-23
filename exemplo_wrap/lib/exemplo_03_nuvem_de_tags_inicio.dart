// exemplo_03_nuvem_de_tags_inicio.dart
// Ponto de partida: as tags ganharam cara de app — ícone + texto + borda.
//
// ! Mas cada chip virou uma barra esticada de ponta a ponta, uma por linha. A
// ! nuvem de tags virou uma lista.
//
// O culpado está dentro do `_Tag`: o `Row` interno, com o `mainAxisSize` no
// padrão (max), estica até a largura que o Wrap ofereceu.
//
// ? E que largura o Wrap oferece? A da run inteira — ele passa aos filhos uma
// ? constraint SOLTA (0 até a largura disponível). Quem escolhe ficar do tamanho
// ? do conteúdo é o filho; com mainAxisSize.max, o Row escolhe o máximo.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoNuvemDeTags()));

const List<String> tags = [
  'Flutter',
  'Dart',
  'Gerenciamento de estado',
  'UI',
  'Testes automatizados',
  'CI/CD',
  'Firebase',
  'REST',
  'Animações',
  'Acessibilidade',
  'Performance',
  'Design System',
];

class DemoNuvemDeTags extends StatelessWidget {
  const DemoNuvemDeTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuvem de tags')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interesses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [for (final String tag in tags) _Tag(texto: tag)],
            ),
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.tag, size: 16, color: Colors.deepPurple),
          const SizedBox(width: 6),
          Text(texto, style: const TextStyle(color: Colors.deepPurple)),
        ],
      ),
    );
  }
}

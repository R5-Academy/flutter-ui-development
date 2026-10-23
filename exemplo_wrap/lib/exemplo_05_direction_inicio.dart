// exemplo_05_direction_inicio.dart
// Ponto de partida: o Wrap no eixo padrão — Axis.horizontal.
//
// * Ele enche a LINHA e, quando não cabe mais, quebra para a próxima LINHA.
// * O `spacing` de 10 é horizontal (entre chips da mesma linha) e o
// * `runSpacing` é vertical (entre as linhas).
//
// Só que o Wrap também sabe quebrar em COLUNAS.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoDirection()));

const List<String> tags = ['A', 'BB', 'CCC', 'DDDD', 'E', 'FF', 'GGG', 'H'];

class DemoDirection extends StatelessWidget {
  const DemoDirection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('direction: horizontal')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // * Palco de largura fixa: o Wrap horizontal só quebra se a LARGURA for
        // * limitada. Numa janela larga esses oito chips caberiam numa linha só.
        child: Container(
          width: 300,
          color: Colors.blueGrey.withValues(alpha: 0.1),
          padding: const EdgeInsets.all(12),
          child: Wrap(
            // Axis.horizontal é o padrão — nem precisa escrever.
            spacing: 10,
            runSpacing: 10,
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blueGrey.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(texto),
    );
  }
}

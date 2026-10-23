// exemplo_01_orientacao_inicio.dart
// Ponto de partida: o badge no topo já lê a orientação da tela com
// `MediaQuery.orientationOf` — o equivalente, para orientação, do `sizeOf`.
//
// ! Mas o card embaixo ignora completamente essa informação: foto em cima,
// ! texto embaixo, sempre. Gire o aparelho (ou alargue a janela no desktop até
// ! ficar mais larga que alta): o badge muda, o layout não.
//
// Ler a orientação é fácil. Falta usá-la.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoOrientacao()));

class DemoOrientacao extends StatelessWidget {
  const DemoOrientacao({super.key});

  @override
  Widget build(BuildContext context) {
    final orientacaoDaTela = MediaQuery.orientationOf(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Retrato x Paisagem')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _BadgeOrientacao(orientacao: orientacaoDaTela),
            const SizedBox(height: 16),
            const Expanded(
              child: Column(
                children: [
                  Expanded(child: _Foto()),
                  SizedBox(height: 16),
                  Expanded(child: _Info()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BadgeOrientacao extends StatelessWidget {
  const _BadgeOrientacao({required this.orientacao});

  final Orientation orientacao;

  @override
  Widget build(BuildContext context) {
    final paisagem = orientacao == Orientation.landscape;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.indigo.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            paisagem
                ? Icons.stay_current_landscape
                : Icons.stay_current_portrait,
            color: Colors.indigo,
          ),
          const SizedBox(width: 8),
          Text(
            'Tela: ${paisagem ? 'paisagem' : 'retrato'}',
            style: const TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _Foto extends StatelessWidget {
  const _Foto();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.teal.withValues(alpha: 0.6),
            Colors.teal.withValues(alpha: 0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Icon(Icons.photo, size: 64, color: Colors.white),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Praia do Rosa',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Santa Catarina, Brasil'),
          SizedBox(height: 12),
          Text(
            'Em retrato a foto fica em cima e o texto embaixo. Em paisagem '
            'sobra largura, então a foto vai para o lado e o texto ocupa a '
            'outra metade.',
          ),
        ],
      ),
    );
  }
}

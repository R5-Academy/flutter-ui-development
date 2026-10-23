// exemplo_03_spacer_vs_spacebetween_inicio.dart
// Ponto de partida: três ícones distribuídos com mainAxisAlignment.spaceBetween.
//
// * Distribuição UNIFORME: joga tudo pras pontas e reparte o resto igualmente.
// * Zero Spacer na árvore — mais limpo, e é a escolha certa para este caso.
//
// A pergunta do bloco é: então quando o Spacer ganha?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: SpacerVsSpaceBetween()));

class SpacerVsSpaceBetween extends StatelessWidget {
  const SpacerVsSpaceBetween({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spacer vs spaceBetween')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _Bloco(
              'mainAxisAlignment.spaceBetween (uniforme)',
              Colors.indigo,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _Icone(Icons.home),
                  _Icone(Icons.search),
                  _Icone(Icons.person),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Icone extends StatelessWidget {
  const _Icone(this.ico);

  final IconData ico;

  @override
  Widget build(BuildContext context) => Icon(ico, size: 32);
}

class _Bloco extends StatelessWidget {
  const _Bloco(this.titulo, this.cor, this.linha);

  final String titulo;
  final Color cor;
  final Widget linha;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      color: cor.withValues(alpha: 0.12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          linha,
        ],
      ),
    );
  }
}

// exemplo_02_main_axis_alignment_inicio.dart
// Ponto de partida: três quadrados numa linha, com o alinhamento padrão.
//
// * O fundo cinza marca a largura TOTAL da linha. Como o mainAxisSize é max
// * (padrão), o Row ocupa toda a largura — e sobra um espaço enorme à direita.
//
// Essa SOBRA é a matéria-prima do mainAxisAlignment: é ela que as seis opções
// distribuem de jeitos diferentes.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaMainAxis()));

class TelaMainAxis extends StatelessWidget {
  const TelaMainAxis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('mainAxisAlignment')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [_LinhaDemo('start (padrão)', MainAxisAlignment.start)],
      ),
    );
  }
}

class _LinhaDemo extends StatelessWidget {
  const _LinhaDemo(this.rotulo, this.alinhamento);

  final String rotulo;
  final MainAxisAlignment alinhamento;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(rotulo, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Container(
            color: Colors.grey.withValues(alpha: 0.2),
            child: Row(
              mainAxisAlignment: alinhamento,
              children: const [
                _Quadrado(Colors.red),
                _Quadrado(Colors.green),
                _Quadrado(Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Quadrado extends StatelessWidget {
  const _Quadrado(this.cor);

  final Color cor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: cor,
    );
  }
}

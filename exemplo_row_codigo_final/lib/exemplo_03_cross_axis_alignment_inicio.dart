// exemplo_03_cross_axis_alignment_inicio.dart
// Ponto de partida: três caixas de ALTURAS diferentes numa linha.
//
// * A altura da linha é ditada pelo filho mais alto (a caixa verde, de 80). As
// * outras duas sobram espaço em cima e embaixo — e estão centralizadas nele,
// * porque `center` é o padrão do crossAxisAlignment.
//
// Saímos do eixo principal (horizontal) para o eixo CRUZADO (vertical).

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaCrossAxis()));

class TelaCrossAxis extends StatelessWidget {
  const TelaCrossAxis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('crossAxisAlignment')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          _LinhaCross(
            'center (padrão)',
            CrossAxisAlignment.center,
            alturaDaLinha: 180,
          ),
          _LinhaCross('start', .start),
          _LinhaCross('end', .end),
          _LinhaCross('stretch', .stretch, alturaDaLinha: 80), // min=80, max=80
        ],
      ),
    );
  }
}

class _LinhaCross extends StatelessWidget {
  const _LinhaCross(this.rotulo, this.alinhamento, {this.alturaDaLinha});

  final String rotulo;
  final CrossAxisAlignment alinhamento;
  final double? alturaDaLinha;

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
            height: alturaDaLinha,
            color: Colors.grey.withValues(alpha: 0.2),
            child: Row(
              crossAxisAlignment: alinhamento,
              children: const [
                _Caixa(Colors.red, 40),
                _Caixa(Colors.green, 80),
                _Caixa(Colors.blue, 56),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Caixa extends StatelessWidget {
  const _Caixa(this.cor, this.altura);

  final Color cor;
  final double altura;

  @override
  Widget build(BuildContext context) {
    return Container(width: 60, height: altura, color: cor);
  }
}

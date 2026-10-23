// exemplo_02_alignment_inicio.dart
// Ponto de partida: as duas caixas ancoradas no padrão do Stack.
//
// * O padrão do `alignment` é `AlignmentDirectional.topStart` — o canto
// * superior esquerdo em layouts da esquerda para a direita. Foi por isso que a
// * caixa rosa do bloco anterior nasceu ali, sem ninguém pedir.
//
// O fundo cinza marca a área do Stack, para dar referência.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: StackAlignment()));

class StackAlignment extends StatelessWidget {
  const StackAlignment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stack.alignment')),
      body: SingleChildScrollView(
        padding: .all(16),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _Palco(
              rotulo: 'topStart (o padrão)',
              alignment: AlignmentDirectional.topStart,
            ),
            _Palco(rotulo: 'topCenter', alignment: .topCenter),
            _Palco(rotulo: 'center', alignment: .center),
            _Palco(rotulo: 'bottomRight', alignment: .bottomRight),
            _Palco(
              rotulo: 'Alignment(0.5, -0.2)',
              alignment: Alignment(0.5, -0.2),
            ),
          ],
        ),
      ),
    );
  }
}

// Um palco de tamanho fixo com um Stack dentro, para comparar alinhamentos.
class _Palco extends StatelessWidget {
  const _Palco({required this.rotulo, required this.alignment});

  final String rotulo;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          rotulo,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 150,
          height: 150,
          color: Colors.grey.withValues(alpha: 0.2),
          // * alignment posiciona TODOS os filhos não posicionados de uma vez —
          // * são duas caixas aqui dentro, e as duas vão para o mesmo canto.
          child: Stack(
            alignment: alignment,
            children: [
              Container(width: 90, height: 90, color: Colors.orange.shade200),
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                color: Colors.deepOrange,
                child: const Text('eu', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// exemplo_04_alignment_inicio.dart
// Ponto de partida: um Wrap num palco de largura fixa, com o alignment padrão.
//
// * O palco tem largura fixa de propósito, por dois motivos:
// *   1. o `alignment` só tem efeito visível quando SOBRA espaço na run —
// *      repare na sobra à direita da primeira run e, ainda maior, na segunda;
// *   2. o Wrap ENCOLHE até a run mais larga quando o pai deixa. Solto, ele não
// *      teria sobra nenhuma para distribuir; é a caixa de 320 que dá a sobra.
//
// Os chips têm alturas diferentes — isso vai importar no segundo grupo.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DemoAlignment()));

class DemoAlignment extends StatelessWidget {
  const DemoAlignment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alinhamentos do Wrap')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Palco(rotulo: 'start (o padrão)', alignment: WrapAlignment.start),
            _Palco(rotulo: 'Center ', alignment: .center),
            _Palco(rotulo: 'end ', alignment: .end),
            _Palco(rotulo: 'spaceBetween ', alignment: .spaceBetween),
            _Palco(rotulo: 'spaceAround ', alignment: .spaceAround),
            _Palco(rotulo: 'spaceEvenly ', alignment: .spaceEvenly),

            SizedBox(height: 12),
            Text('crossAxisAlignment — alturas dentro da linha'),
            _Palco(
              rotulo: 'start (o padrão)',
              alignment: WrapAlignment.start,
              crossAxisAlignment: .start,
            ),

            _Palco(
              rotulo: 'center',
              alignment: WrapAlignment.start,
              crossAxisAlignment: .center,
            ),
            _Palco(
              rotulo: 'center',
              alignment: WrapAlignment.start,
              crossAxisAlignment: .end,
            ),
          ],
        ),
      ),
    );
  }
}

// Um palco de largura fixa com um Wrap dentro, para comparar alinhamentos.
class _Palco extends StatelessWidget {
  const _Palco({
    required this.rotulo,
    required this.alignment,
    this.crossAxisAlignment = .start,
  });

  final String rotulo;
  final WrapAlignment alignment;
  final WrapCrossAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            rotulo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: 320,
            color: Colors.amber.withValues(alpha: 0.15),
            padding: const EdgeInsets.all(8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: alignment,
              crossAxisAlignment: crossAxisAlignment,
              children: const [
                _ChipAltura(altura: 32),
                _ChipAltura(altura: 52),
                _ChipAltura(altura: 72),
                _ChipAltura(altura: 32),
                _ChipAltura(altura: 35),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Chip de LARGURA fixa e alturas diferentes (o número dentro é a própria
// altura). A altura variada é o que o crossAxisAlignment vai alinhar.
//
// ! A largura tem de ser fixa. Um Container com `alignment` e SEM largura vira um
// ! Align sem widthFactor: ele estica até o máximo que o pai oferece. E o Wrap
// ! oferece a largura inteira da run — cada chip ficaria do tamanho da run, um
// ! por linha, e nenhum `alignment` teria sobra para distribuir.
class _ChipAltura extends StatelessWidget {
  const _ChipAltura({required this.altura});

  final double altura;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: altura,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text('${altura.toInt()}'),
    );
  }
}

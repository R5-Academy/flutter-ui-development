import 'dart:math' as math;

import 'package:flutter/material.dart';

// ! ESTE ARQUIVO ESTOURA DE PROPÓSITO. É a armadilha nº 1 do GridView.
//
// Uma grade de produtos com childAspectRatio: 2.0.
//
// ! Rode e olhe: a listra amarela e preta em TODOS os cards, e o console
// ! cheio de "A RenderFlex overflowed by 32 pixels on the bottom".
//
// O card pede 132px de altura (medido). Numa grade de 400 com 2 colunas a
// célula fica com 200 de largura e, por causa do ratio 2.0, só 100 de altura.
// Faltam 32 — e a célula NÃO cresce para caber o filho.
//
// ! O PALCO (kPalco): sem ele, o resultado deste arquivo dependeria do tamanho
// ! da sua janela. Numa janela larga, 2 colunas dariam células mais largas,
// ! logo mais altas, e o overflow SUMIRIA — o que é a própria lição da aula: a
// ! altura da célula é derivada da largura. Com o palco, o número é o mesmo na
// ! sua tela e na do aluno. (Numa janela mais estreita que kPalco o overflow
// ! aumenta; ele nunca some.)
const double kPalco = 400.0;
const int kColunas = 2;
const double kAspectRatio = 1.3;

void main() => runApp(const AppDoAspectRatio());

class AppDoAspectRatio extends StatelessWidget {
  const AppDoAspectRatio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A armadilha do childAspectRatio',
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
      home: const TelaDoAspectRatio(),
    );
  }
}

class TelaDoAspectRatio extends StatelessWidget {
  const TelaDoAspectRatio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('childAspectRatio = largura / altura')),
      body: Column(
        children: <Widget>[
          const _Conta(colunas: kColunas, aspectRatio: kAspectRatio),
          Expanded(
            // O palco: a grade nunca passa de kPalco de largura, para os
            // números da aula baterem em qualquer janela.
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: kPalco),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: kColunas,
                    // ! A célula NÃO cresce para caber o filho.
                    // ! Com 2.0 ela fica metade da largura de altura. O card
                    // ! não cabe, e estoura.
                    childAspectRatio: kAspectRatio,
                  ),
                  itemCount: 40,
                  itemBuilder: (context, indice) =>
                      _CardDeProduto(indice: indice),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Conta extends StatelessWidget {
  const _Conta({required this.colunas, required this.aspectRatio});

  final int colunas;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    // A largura da GRADE, não a da tela: o palco limita em kPalco.
    final larguraDaGrade = math.min(MediaQuery.sizeOf(context).width, kPalco);
    // A conta que o delegate faz por baixo (fonte: sliver_grid.dart:394-399):
    //   largura = (disponivel - crossAxisSpacing * (colunas - 1)) / colunas
    //   altura  = largura / childAspectRatio
    final larguraDaCelula = larguraDaGrade / colunas;
    final alturaDaCelula = larguraDaCelula / aspectRatio;

    return Container(
      color: Colors.deepPurple.shade50,
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'A célula está com '
            '${larguraDaCelula.toStringAsFixed(0)} x '
            '${alturaDaCelula.toStringAsFixed(0)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            'conta: $colunas colunas -> largura '
            '${larguraDaCelula.toStringAsFixed(0)}; '
            'altura = ${larguraDaCelula.toStringAsFixed(0)} / '
            '${aspectRatio.toStringAsFixed(2)}',
          ),
          Text('childAspectRatio: ${aspectRatio.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}

// Um card comum: ícone, título, preço e parcelamento. Precisa de uns 130px de
// altura para caber sem apertar.
class _CardDeProduto extends StatelessWidget {
  const _CardDeProduto({required this.indice});

  final int indice;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.photo, size: 40),
            const SizedBox(height: 8),
            Text(
              'Produto $indice',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('R\$ 99,90'),
            const SizedBox(height: 4),
            const Text('em até 3x', style: TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

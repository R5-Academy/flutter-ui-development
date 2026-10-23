import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

// A mesma grade do 03_aspect_ratio_errado.dart, com o childAspectRatio
// ajustado para o card caber.
//
// O cabeçalho mostra a conta: quanto mede a célula com esses valores.
//
// Troque o kColunas para 3, depois 4, e dê hot reload a cada troca.
//
// ! Repare no efeito colateral: você mexeu no número de COLUNAS e a ALTURA
// ! mudou sozinha. É esse o comportamento que ninguém espera.

// O palco: a grade nunca passa desta largura, para o número na sua tela ser o
// mesmo da aula.
const double kPalco = 400.0;
const int kColunas = 2;

// A razão largura/altura. Enquanto kAlturaDaCelula for null, é ela que manda:
// a altura sai de largura / kAspectRatio.
const double kAspectRatio = 0.85;

// null  -> a altura é DERIVADA da largura, pela razão acima.
// 150.0 -> a altura é CRAVADA em pixels e a razão para de valer.
const double? kAlturaDaCelula = null;

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
      appBar: AppBar(title: const Text('A altura da célula')),
      body: Column(
        children: <Widget>[
          const _PainelDaCelula(),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: kPalco),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: kColunas,
                    // A célula NÃO cresce para caber o filho: a altura sai da
                    // conta largura / childAspectRatio.
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

// O painel serve aos dois estados: enquanto kAlturaDaCelula for null ele mostra
// a altura derivada da razão; quando ela tiver valor, mostra a altura cravada.
class _PainelDaCelula extends StatelessWidget {
  const _PainelDaCelula();

  @override
  Widget build(BuildContext context) {
    // A largura da GRADE, não a da tela: o palco limita em kPalco.
    final larguraDaGrade = math.min(MediaQuery.sizeOf(context).width, kPalco);
    // A conta que o delegate faz por baixo (fonte: sliver_grid.dart:394-399):
    //   largura = (disponivel - crossAxisSpacing * (colunas - 1)) / colunas
    //   altura  = mainAxisExtent ?? largura / childAspectRatio
    final larguraDaCelula = larguraDaGrade / kColunas;
    final alturaDaCelula = kAlturaDaCelula ?? larguraDaCelula / kAspectRatio;
    final cravada = kAlturaDaCelula != null;

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
            cravada
                ? 'altura CRAVADA: mainAxisExtent = '
                      '${alturaDaCelula.toStringAsFixed(0)}'
                : 'altura DERIVADA: '
                      '${larguraDaCelula.toStringAsFixed(0)} / '
                      '${kAspectRatio.toStringAsFixed(2)} = '
                      '${alturaDaCelula.toStringAsFixed(0)}',
          ),
          Text(
            cravada
                ? 'Troque o kColunas: a largura muda, a altura NÃO.'
                : 'Troque o kColunas: a largura muda e a altura vai junto.',
          ),
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

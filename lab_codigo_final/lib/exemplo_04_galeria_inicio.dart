// exemplo_04_galeria_inicio.dart
// Uma galeria de 300 produtos numa grade de duas colunas.
//
// Os dados e o card já estão prontos. A grade funciona e rola liso.
//
// ! Gire o aparelho (ou redimensione a janela): continuam duas colunas, agora
// ! enormes. E os cards estão colados uns nos outros.
//
// Falta deixar a grade responsiva e dar respiro entre os cards.

import 'package:flutter/material.dart';

void main() => runApp(const AppDaGaleria());

class AppDaGaleria extends StatelessWidget {
  const AppDaGaleria({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galeria',
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const TelaDaGaleria(),
    );
  }
}

// Um produto qualquer. Em app de verdade viria da API.
class Produto {
  const Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.cor,
  });

  final int id;
  final String nome;
  final double preco;
  // MaterialColor (não Color) para termos os tons .shade200 / .shade800
  final MaterialColor cor;
}

final List<Produto> produtos = .generate(300, (indice) {
  return Produto(
    id: indice,
    nome: 'Produto ${indice + 1}',
    preco: 19.9 + (indice % 30) * 7.5,
    cor: Colors.primaries[indice % Colors.primaries.length],
  );
});

class TelaDaGaleria extends StatelessWidget {
  const TelaDaGaleria({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Galeria — 300 produtos')),
      body: GridView.builder(
        padding: .all(12),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          mainAxisExtent: 210,
        ),
        itemCount: produtos.length,
        itemBuilder: (context, indice) =>
            CardDoProduto(produto: produtos[indice]),
      ),
    );
  }
}

class CardDoProduto extends StatelessWidget {
  const CardDoProduto({super.key, required this.produto});

  final Produto produto;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // A "imagem". Num app real seria Image.network com cacheWidth.
          Expanded(
            child: ColoredBox(
              color: produto.cor.shade200,
              child: Center(
                child: Icon(
                  Icons.shopping_bag_outlined,
                  size: 40,
                  color: produto.cor.shade800,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  produto.nome,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  'R\$ ${produto.preco.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.green.shade800),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

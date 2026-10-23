// exemplo_03_shrink_inicio.dart
// Ponto de partida: uma lista de produtos, cada um com um selo de frete grátis.
//
// ! Só que nem todo produto TEM frete grátis. Repare no `temFreteGratis` de
// ! cada um: dois são false, e mesmo assim o selo aparece nos quatro.
//
// A pergunta da vez: como NÃO desenhar nada nesses dois? Não existe "devolver
// null" — todo slot de widget exige um Widget. Qual é o widget que significa
// "nada"?
//
// * Andaime: `ListView`, `Row` e `Expanded` vêm depois (Layouts Flexíveis e
// * Scrollables). Aqui eles só montam a lista e empurram o selo para a direita.
// * O foco é o selo aparecer ou não.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ExemploShrink()));

class _Produto {
  const _Produto(this.nome, {required this.temFreteGratis});

  final String nome;
  final bool temFreteGratis;
}

const List<_Produto> _catalogo = [
  _Produto('Fone bluetooth', temFreteGratis: true),
  _Produto('Cabo USB-C', temFreteGratis: false),
  _Produto('Teclado mecânico', temFreteGratis: true),
  _Produto('Suporte de mesa', temFreteGratis: false),
];

class ExemploShrink extends StatelessWidget {
  const ExemploShrink({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SizedBox.shrink')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final _Produto produto in _catalogo)
            _LinhaDoProduto(produto: produto),
        ],
      ),
    );
  }
}

class _LinhaDoProduto extends StatelessWidget {
  const _LinhaDoProduto({required this.produto});

  final _Produto produto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(produto.nome)),
          produto.temFreteGratis ? const _SeloFreteGratis() : SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _SeloFreteGratis extends StatelessWidget {
  const _SeloFreteGratis();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'Frete grátis',
        style: TextStyle(color: Colors.green.shade900),
      ),
    );
  }
}

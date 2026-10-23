// exemplo_02_grid_colunas_inicio.dart
// Ponto de partida: os cards num Wrap, com largura FIXA de 180.
//
// O Wrap já evita o overflow — ele quebra linha quando não cabe. Mas repare no
// resultado numa janela larga: sobra uma faixa vazia à direita, porque 180 não
// divide a largura de forma exata. Numa janela de 1280 cabem 6 cards por linha
// (6*180 + 5*12 = 1140) e sobram 108px de faixa morta.
//
// ! E numa janela estreita não acontece o que a maioria espera: NÃO estoura.
// ! Medido (SDK 3.44.6) numa janela de 150px, o card sai com 118px de largura —
// ! não com 180. O `SizedBox` não impõe o tamanho: ele aplica o que pediu
// ! DENTRO das constraints do pai (`enforce`), e o Wrap passa maxWidth = espaço
// ! disponível. Resultado: o card encolhe calado, sem listra amarela nenhuma.
// ! Esse é o bug traiçoeiro do tamanho fixo — ele não reclama, ele deforma.
//
// Queremos que os cards se ESTIQUEM para preencher a largura, mantendo um
// tamanho mínimo confortável de verdade.

import 'package:flutter/material.dart';

const double larguraMinimaCard = 180;
const double espaco = 12;

const List<String> produtos = [
  'Tênis',
  'Camiseta',
  'Calça',
  'Boné',
  'Jaqueta',
  'Meia',
  'Mochila',
  'Relógio',
  'Óculos',
  'Carteira',
];

void main() => runApp(const MaterialApp(home: DemoGridResponsivo()));

class DemoGridResponsivo extends StatelessWidget {
  const DemoGridResponsivo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grid que muda de colunas')),
      body: LayoutBuilder(
        builder: (_, constrains) {
          final largura = constrains.maxWidth - 32;

          final colunas = ((largura - espaco) / (larguraMinimaCard + espaco))
              .floor()
              .clamp(1, 3);

          final larguraCard = (largura - espaco * (colunas - 1)) / colunas;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: espaco,
              runSpacing: espaco,
              children: [
                for (final String nome in produtos)
                  SizedBox(
                    width: larguraCard,
                    child: _CardProduto(nome: nome),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CardProduto extends StatelessWidget {
  const _CardProduto({required this.nome});

  final String nome;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.shopping_bag, color: Colors.deepPurple),
          const SizedBox(height: 8),
          Text(nome, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text(r'R$ 99,90', style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}

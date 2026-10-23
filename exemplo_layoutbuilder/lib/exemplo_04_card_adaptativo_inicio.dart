// exemplo_04_card_adaptativo_inicio.dart
// Ponto de partida: um componente `CardProduto` reutilizável — imagem em cima,
// texto embaixo, sempre.
//
// O bloco 2 trocou o layout de uma TELA. Aqui a decisão vai morar dentro de um
// COMPONENTE, que é como isso vive num app de verdade: quem usa o card não
// precisa saber que ele se adapta.
//
// * Os dois cards abaixo são o MESMO componente em dois espaços diferentes, na
// * MESMA tela: o de cima recebe a largura toda do corpo; o de baixo mora numa
// * coluna de 260px, como aconteceria num tablet dividido em duas colunas.
//
// A pergunta do bloco: os dois estão com o MESMO formato. No de cima sobra um
// vazio enorme à direita da imagem; no de baixo não sobra nada. Como o card pode
// descobrir isso sozinho, sem quem o usa avisar?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaCardAdaptativo()));

const _descricao = 'Cancelamento de ruído ativo e 30h de bateria.';

class TelaCardAdaptativo extends StatelessWidget {
  const TelaCardAdaptativo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Um componente, dois espaços')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          // ! `start`, e não `stretch`: com `stretch` a Column mandaria largura
          // ! TIGHT para os filhos e a coluna de 260px lá embaixo seria
          // ! ignorada. É a mesma pegadinha do exemplo 01.
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Espaço largo — a largura toda do corpo:'),
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: CardProduto(
                titulo: 'Fone Bluetooth ANC',
                descricao: _descricao,
                preco: r'R$ 349,90',
              ),
            ),
            SizedBox(height: 16),
            Text('Espaço estreito — uma coluna de 260px:'),
            SizedBox(height: 8),
            SizedBox(
              width: 260,
              child: CardProduto(
                titulo: 'Fone Bluetooth ANC',
                descricao: _descricao,
                preco: r'R$ 349,90',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardProduto extends StatelessWidget {
  const CardProduto({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.preco,
  });

  final String titulo;
  final String descricao;
  final String preco;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const _ImagemProduto(),
            const SizedBox(height: 16),
            _Descricao(titulo: titulo, descricao: descricao, preco: preco),
          ],
        ),
      ),
    );
  }
}

class _ImagemProduto extends StatelessWidget {
  const _ImagemProduto();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.headphones, size: 48, color: Colors.deepOrange),
    );
  }
}

class _Descricao extends StatelessWidget {
  const _Descricao({
    required this.titulo,
    required this.descricao,
    required this.preco,
  });

  final String titulo;
  final String descricao;
  final String preco;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          titulo,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(descricao),
        const SizedBox(height: 12),
        Text(
          preco,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
      ],
    );
  }
}

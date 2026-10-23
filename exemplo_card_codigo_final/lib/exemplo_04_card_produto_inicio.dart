// exemplo_04_card_produto_inicio.dart
// Ponto de partida: o card de produto montado — foto no topo, textos e rodapé
// com preço e nota. Tudo o que a aula construiu até aqui está aplicado.
//
// ! Rode e olhe os DOIS CANTOS DE CIMA. O Card é arredondado, a foto não: ela
// ! avança por cima da curva e devolve dois cantos quadrados. O card fica com
// ! "orelhas".
//
// ? O `shape` do Card está arredondado. Por que a imagem não respeita?
//
// Porque desenhar a própria borda e recortar os filhos são duas coisas
// diferentes — e a segunda o Card não faz por padrão.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: CardProduto()));

class CardProduto extends StatelessWidget {
  const CardProduto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: const Text('Card de produto')),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Card(
            elevation: 3,
            // Raio bem redondo para o problema ficar impossível de não ver.
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: .hardEdge,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_FotoDoProduto(), _DadosDoProduto()],
            ),
          ),
        ),
      ),
    );
  }
}

class _FotoDoProduto extends StatelessWidget {
  const _FotoDoProduto();

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://picsum.photos/id/1060/600/400',
      height: 160,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => SizedBox(
        height: 160,
        child: ColoredBox(
          color: Colors.grey.shade300,
          child: const Center(child: Icon(Icons.image_not_supported)),
        ),
      ),
    );
  }
}

class _DadosDoProduto extends StatelessWidget {
  const _DadosDoProduto();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Café especial torra média',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black.withValues(alpha: 0.87),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Grãos selecionados, notas de chocolate e caramelo.',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text(
                r'R$ 39,90',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.green,
                ),
              ),
              const Spacer(),
              Icon(Icons.star, size: 18, color: Colors.amber.shade700),
              const SizedBox(width: 4),
              const Text('4.8'),
            ],
          ),
        ],
      ),
    );
  }
}

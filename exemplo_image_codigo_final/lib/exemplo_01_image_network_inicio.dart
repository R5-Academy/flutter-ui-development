// exemplo_01_image_network_inicio.dart
// Ponto de partida: a página de um produto da loja. Nome, preço e descrição já
// aparecem — o backend devolveu o produto inteiro.
//
// ! Olhe o `_Produto`: ele tem um campo `fotoUrl`. A tela não usa.
// ! Uma página de produto sem foto é uma página que não vende.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaDoProduto()));

class _Produto {
  const _Produto({
    required this.nome,
    required this.preco,
    required this.descricao,
    required this.fotoUrl,
  });

  final String nome;
  final String preco;
  final String descricao;
  final String fotoUrl;
}

// O picsum.photos devolve uma foto de verdade no tamanho que você pedir. Serve
// para o exemplo rodar sem depender de nenhum arquivo no projeto.
const _produto = _Produto(
  nome: 'Fone Bluetooth XZ-90',
  preco: r'R$ 299,90',
  descricao: 'Cancelamento de ruído ativo e 30 horas de bateria.',
  fotoUrl: 'https://picsum.photos/400/300',
);

class TelaDoProduto extends StatelessWidget {
  const TelaDoProduto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produto')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              _produto.fotoUrl,
              width: 300,
              height: 225,
              errorBuilder: (context, error, stackTrace) {
                return SizedBox(
                  width: 300,
                  height: 225,
                  child: ColoredBox(
                    color: Color(0xFFEEEEEE),
                    child: Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            ),
            Text(
              _produto.nome,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              _produto.preco,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.teal,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _produto.descricao,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

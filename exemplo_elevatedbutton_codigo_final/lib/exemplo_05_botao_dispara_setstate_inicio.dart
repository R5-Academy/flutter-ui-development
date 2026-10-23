// exemplo_05_botao_dispara_setstate_inicio.dart
// Ponto de partida: o carrinho, juntando tudo o que a aula construiu. O
// "Adicionar" dispara `setState` e o contador sobe — isso já funciona.
//
// ! Agora, com o carrinho zerado, toque em "Finalizar compra". O pedido é
// ! finalizado com ZERO itens.
//
// ! Um botão que não pode ser usado agora não deveria estar disponível agora. A
// ! alternativa preguiçosa é deixar clicar e mostrar um erro — mas aí você faz a
// ! pessoa descobrir a regra errando.
//
// Você já tem a ferramenta para resolver isso. Falta aplicá-la.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Carrinho()));

class Carrinho extends StatefulWidget {
  const Carrinho({super.key});

  @override
  State<Carrinho> createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  int _itens = 0;

  void _adicionar() {
    // setState avisa o Flutter que o estado mudou e o build roda de novo.
    setState(() => _itens++);
  }

  void _finalizar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pedido com $_itens item(ns) finalizado!')),
    );
    setState(() => _itens = 0);
  }

  @override
  Widget build(BuildContext context) {
    final vazio = _itens == 0;
    return Scaffold(
      appBar: AppBar(title: const Text('Carrinho')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Itens: $_itens',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: _adicionar,
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Adicionar ao carrinho'),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              // ! Sempre habilitado, mesmo com o carrinho vazio.
              onPressed: vazio ? null : _finalizar,
              child: const Text('Finalizar compra'),
            ),
          ],
        ),
      ),
    );
  }
}

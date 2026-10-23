// exemplo_01_iconbutton_basico_inicio.dart
// Ponto de partida: o coração de favoritar, feito com um `Icon` dentro de um
// `GestureDetector`. Toque e o SnackBar aparece — funciona.
//
// ! Mas experimente tocar de leve, um pouco fora do coração. Não pega. O alvo
// ! é do tamanho exato do desenho: 24 pixels — medido, o toque já falha a 13
// ! pixels do centro. A recomendação de acessibilidade é 48.
//
// ! E ainda faltam três coisas: não há efeito de toque (nada confirma o
// ! clique), não há dica dizendo o que o ícone faz, e — o pior — para o leitor
// ! de tela isto NÃO é um botão. O nó de semântica sai com 24x24, sem nome e
// ! sem papel de botão. Um `Icon` sozinho, sem o GestureDetector, nem nó gera.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: IconButtonBasico()));

class IconButtonBasico extends StatelessWidget {
  const IconButtonBasico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('IconButton básico')),
      body: Center(
        child: IconButton(
          tooltip: 'Favoritar',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Adicionado aos favoritos')),
            );
          },
          icon: const Icon(Icons.favorite),
        ),
      ),
    );
  }
}

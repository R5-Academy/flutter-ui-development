// exemplo_04_toggle_favoritar_inicio.dart
// Ponto de partida: o botão de favoritar de verdade — ele alterna. O ícone
// troca de contorno para cheio a cada toque, resolvido com um ternário dentro
// do `icon:`, que é o que a gente já sabe fazer.
//
// Funciona. Mas repare em duas coisas ao alternar:
//
// ! 1. Só o desenho muda. O botão continua com o MESMO fundo nos dois estados
// !    (medido: #E8DEF8 ligado e desligado) — nada além do ícone diz "isto está
// !    ligado". E o leitor de tela também não sabe: para ele nada aconteceu.
// ! 2. O ternário se repete: um no `icon`, outro no `tooltip`. A cada detalhe
// !    que depender do estado, mais um.
//
// ? O Flutter tem noção de "botão selecionado"? Tem — e é uma API própria.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: ToggleFavoritar()));

class ToggleFavoritar extends StatefulWidget {
  const ToggleFavoritar({super.key});

  @override
  State<ToggleFavoritar> createState() => _ToggleFavoritarState();
}

class _ToggleFavoritarState extends State<ToggleFavoritar> {
  // Estado: true quando o item está favoritado.
  bool _favoritado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritar (toggle)')),
      body: Center(
        child: IconButton.filledTonal(
          // ! Um ternário para o ícone...
          icon: Icon(_favoritado ? Icons.favorite : Icons.favorite_border),
          // ! ...e outro para o tooltip.
          tooltip: _favoritado ? 'Remover dos favoritos' : 'Favoritar',
          onPressed: () {
            setState(() => _favoritado = !_favoritado);
          },
        ),
      ),
    );
  }
}

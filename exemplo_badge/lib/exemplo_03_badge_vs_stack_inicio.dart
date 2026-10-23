// exemplo_03_badge_vs_stack_inicio.dart
// Ponto de partida: o carrinho com a contagem no canto, feito do jeito que a
// gente já sabia fazer desde Layouts Avançados — `Stack` + `Positioned`.
//
// Com 5 itens parece resolvido. Agora olhe o segundo carrinho, o de 12: o "12"
// não está DENTRO da bolinha, está atravessando ela.
//
// ! Quatro decisões foram chutadas aqui, e nenhuma é sobre o SEU app:
// ! - `top: -4`, `right: -6`: de onde vieram esses números? Do olho.
// ! - `minWidth: 20`: para o círculo não achatar quando o número tem 1 dígito.
// ! - `0xFFB3261E`: um hex copiado da paleta do Material, na unha.
// ! - `clipBehavior: Clip.none`: senão a bolinha é cortada pelo Stack.
// !
// ! E uma delas está errada. `shape: BoxShape.circle` desenha um círculo com o
// ! diâmetro do MENOR lado da caixa: a caixa cresce com o texto, o círculo não.
// ! Com um dígito o texto cabe; com dois, o texto fica mais largo que o círculo
// ! e vaza pelos lados. O marcador de contagem não é um círculo — é uma cápsula
// ! (um "stadium"), que cresce na horizontal. Quem faz na mão descobre isso
// ! quando o app já está publicado.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaComparacao()));

class TelaComparacao extends StatelessWidget {
  const TelaComparacao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contagem no canto')),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Stack na mão'),
            SizedBox(height: 24),
            _CarrinhoNaMao(quantidade: 5),
            SizedBox(height: 32),
            _CarrinhoNaMao(quantidade: 12),
          ],
        ),
      ),
    );
  }
}

class _CarrinhoNaMao extends StatelessWidget {
  const _CarrinhoNaMao({required this.quantidade});

  final int quantidade;

  @override
  Widget build(BuildContext context) {
    return Stack(
      // clipBehavior none para o marcador poder vazar um pouco do ícone.
      clipBehavior: Clip.none,
      children: [
        // Filho não-posicionado: define o tamanho do Stack (o ícone).
        const Icon(Icons.shopping_cart, size: 44),

        // Filho posicionado: a bolinha no canto, com número dentro.
        Positioned(
          top: -4,
          right: -6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            constraints: const BoxConstraints(minWidth: 20),
            decoration: const BoxDecoration(
              // Vermelho de erro da paleta baseline do Material 3, copiado à
              // mão. Ele não vem do tema: é um número congelado no arquivo.
              color: Color(0xFFB3261E),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$quantidade',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}

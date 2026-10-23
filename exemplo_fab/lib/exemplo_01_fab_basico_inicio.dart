// exemplo_01_fab_basico_inicio.dart
// Ponto de partida: a tela do carrinho. A lista de produtos rola, e o botão de
// adicionar item está dentro dela, no meio do conteúdo.
//
// ! Role a lista até o fim. O botão "Adicionar item" sai da tela junto com o
// ! conteúdo — a ação principal some exatamente quando a pessoa está olhando o
// ! resto dos produtos e é mais provável que queira adicionar mais um.
//
// ! E ele está no meio do caminho da leitura, quando deveria estar sempre ao
// ! alcance do polegar.
//
// A ação principal de uma tela precisa de um lugar próprio — e o `Scaffold`
// tem um slot exatamente para isso.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: FabBasico()));

class FabBasico extends StatefulWidget {
  const FabBasico({super.key});

  @override
  State<FabBasico> createState() => _FabBasicoState();
}

class _FabBasicoState extends State<FabBasico> {
  int _itens = 0;

  static const _produtos = [
    'Café em grãos 1 kg',
    'Filtro de papel nº 103',
    'Açúcar mascavo 500 g',
    'Leite integral 1 L',
    'Chocolate 70% 100 g',
    'Chá de hortelã 20 saquês',
    'Biscoito integral 200 g',
    'Mel silvestre 300 g',
    'Granola sem açúcar 500 g',
    'Castanha de caju 200 g',
    'Suco de uva integral 1 L',
    'Pão de forma integral',
    'Manteiga com sal 200 g',
    'Queijo minas 400 g',
    'Iogurte natural 500 g',
    'Azeite extra virgem 500 ml',
    'Arroz integral 1 kg',
    'Feijão carioca 1 kg',
    'Macarrão grano duro 500 g',
    'Molho de tomate 340 g',
    'Sal marinho 1 kg',
    'Farinha de trigo 1 kg',
    'Ovos caipira dúzia',
    'Detergente neutro 500 ml',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carrinho')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Itens no carrinho: $_itens',
              style: const TextStyle(fontSize: 24),
            ),
          ),
          // ! A ação principal, presa dentro do conteúdo que rola.
          Center(
            child: ElevatedButton(
              onPressed: () => setState(() => _itens++),
              child: const Text('Adicionar item'),
            ),
          ),
          const Divider(height: 32),
          for (final produto in _produtos)
            ListTile(
              leading: const Icon(Icons.shopping_bag_outlined),
              title: Text(produto),
            ),
        ],
      ),
    );
  }
}

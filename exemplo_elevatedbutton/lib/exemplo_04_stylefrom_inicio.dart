// exemplo_04_stylefrom_inicio.dart
// Ponto de partida: três botões com pesos MUITO diferentes na mesma tela.
//
//   "Comprar agora"        -> a ação principal, o objetivo da tela
//   "Continuar comprando"  -> uma ação secundária, de apoio
//   "Excluir conta"        -> destrutiva, sem volta
//
// ! Os três estão com o MESMO estilo — o default do Material 3, medido: fundo
// ! quase branco (surfaceContainerLow), rótulo roxo (primary), forma de pílula
// ! e a mesma sombra de elevation 1. Só a largura muda, porque o texto é maior
// ! ou menor.
// !
// ! A tela não diz o que é importante e não avisa o que é perigoso — e "Excluir
// ! conta" com a mesma cara de "Comprar" é um convite a um acidente.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: BotaoEstilizado()));

class BotaoEstilizado extends StatelessWidget {
  const BotaoEstilizado({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estilizando o botão')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Comprar agora'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Continuar comprando'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Excluir conta'),
            ),
          ],
        ),
      ),
    );
  }
}

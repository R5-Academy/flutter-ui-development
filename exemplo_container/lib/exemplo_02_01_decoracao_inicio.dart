// exemplo_02_01_decoracao_inicio.dart
// Ponto de partida: uma caixa branca com o atalho `color:`.
//
// Funciona bem enquanto você só quer uma cor chapada. Agora peça borda e cantos
// arredondados — e descubra que o `color:` não tem onde encaixar isso.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoDecoracao()));

class DemoDecoracao extends StatelessWidget {
  const DemoDecoracao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Container(
          width: 200,
          height: 120,
          // ? "Mas o alignment não fazia o Container esticar?" Fazia, no bloco
          // ? anterior, porque lá não havia tamanho nenhum. Aqui width/height já
          // ? fixaram a caixa em 200x120, e sobre isso o alignment não manda: ele
          // ? só decide onde o TEXTO fica dentro dos 200x120.
          alignment: Alignment.center,
          // O atalho: por baixo dos panos vira BoxDecoration(color: ...).
          color: Colors.white,
          child: const Text('Caixa simples'),
        ),
      ),
    );
  }
}

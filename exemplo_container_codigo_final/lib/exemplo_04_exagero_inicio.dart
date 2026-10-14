// exemplo_04_exagero_inicio.dart
// Ponto de partida: dois Containers usando UMA capacidade cada.
//
// ! Os dois funcionam. E os dois são exagero: nenhum deles pode ser const,
// ! porque o Container não tem construtor const — então são reconstruídos a
// ! cada build, sem necessidade.
//
// Para cada um deles existe um widget específico. Refatore e compare com o
// exemplo_04_exagero_completo.dart.
//
// * O mapa completo (vale a pena ir ao quadro com ele — cada linha é uma das
// * próximas aulas desta seção):
// *   só cor            -> ColoredBox
// *   só padding        -> Padding          (aula 02)
// *   só posição        -> Align / Center   (aulas 03 e 04)
// *   só tamanho fixo   -> SizedBox         (aula 05)
// *   só min/max        -> ConstrainedBox   (aula 06)
// *   só borda/sombra   -> DecoratedBox
// * Duas ou mais dessas juntas -> aí sim o Container compensa (é o card do
// * exemplo_03). Esta é a regra da aula, e ela vale para as SEIS linhas: as aulas
// * seguintes não vão repetir este refactor parâmetro por parâmetro.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DemoExagero()));

class DemoExagero extends StatelessWidget {
  const DemoExagero({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        // * Column ainda não foi ensinada — aqui ela só empilha os exemplos na
        // * demonstração. O foco é o conteúdo de cada item.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ! Container só para pintar um fundo.
            ColoredBox(color: Colors.amber, child: Text('Fundo amarelo')),
            // Container(color: Colors.amber, child: Text('Fundo amarelo')),
            SizedBox(width: 10, height: 24),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text('Texto com respiro'),
            ),
            // ! Container só para dar padding.
            // Container(
            //   padding: EdgeInsets.all(16),
            //   child: Text('Texto com respiro'),
            // ),
          ],
        ),
      ),
    );
  }
}

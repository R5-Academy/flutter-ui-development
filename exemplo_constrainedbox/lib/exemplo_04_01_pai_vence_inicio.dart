// exemplo_04_01_pai_vence_inicio.dart
// Ponto de partida: a ARMADILHA clássica. Pedimos minWidth: 400 e recebemos 150.
//
// * O PAI é um SizedBox de 150 de largura: ele passa ao filho uma constraint
// * TIGHT (min == max == 150). 150 é o teto absoluto.
// ! O enforce clampeia o nosso 400 dentro da faixa do pai [150, 150]:
// ! clamp(400, 150, 150) = 150. O pai simplesmente não tem 400 para dar.
//
// * A caixa vermelha desenha o tamanho REAL que o filho recebeu (medido:
// * 150x80). Se ela não tem os 400 que pedimos, foi o pai que venceu. Não há
// * bug — é o enforce respeitando a faixa de quem está acima.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaPaiVence()));

class TelaPaiVence extends StatelessWidget {
  const TelaPaiVence({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quando o pai vence')),
      body: Center(
        child: SizedBox(
          width: 150,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 400),
            child: const _CaixaMedida(rotulo: 'pedi 400,\nrecebi 150'),
          ),
        ),
      ),
    );
  }
}

class _CaixaMedida extends StatelessWidget {
  const _CaixaMedida({required this.rotulo});

  final String rotulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.red,
      // Align com os fatores em 1 faz a caixa ABRAÇAR o conteúdo (aula de
      // Align), então a largura que aparece na tela é a que sobrou do enforce.
      // ! Com `alignment: Alignment.center` no Container em vez disto, a caixa
      // ! esticaria até o MÁXIMO permitido e mediria a tela toda — escondendo
      // ! justamente o número que a gente quer ler aqui.
      child: Align(
        widthFactor: 1,
        heightFactor: 1,
        child: Text(
          rotulo,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

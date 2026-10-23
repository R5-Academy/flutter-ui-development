// exemplo_03_arbitrario_inicio.dart
// Ponto de partida: um Alignment montado na mão, com dois números quaisquer.
//
// Alignment(0.3, -0.5) não é nenhuma das nove âncoras — e funciona igual.
// x e y são CONTÍNUOS: qualquer valor entre -1 e +1 vale.
//
// Medido: palco de 278, marcador de 56, espaço livre de 222. O marcador cai em
// (144,3 · 55,5): x = 0.3 é 30% do caminho do centro até a borda direita, e
// y = -0.5 é a metade do caminho do centro até o topo.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaArbitraria()));

const double ladoPalco = 280;

class TelaArbitraria extends StatelessWidget {
  const TelaArbitraria({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alignment arbitrário')),
      // O Align de fora só centraliza o palco na tela — sem alignment, o padrão
      // dele já é o centro.
      body: Align(
        child: Container(
          width: ladoPalco,
          height: ladoPalco,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border.all(color: Colors.grey),
          ),
          child: const Align(
            // * -1 = topo/esquerda · 0 = centro · +1 = base/direita.
            alignment: Alignment(0.3, -0.5),
            child: _Marcador(rotulo: '0.3\n-0.5', cor: Colors.deepPurple),
          ),
        ),
      ),
    );
  }
}

class _Marcador extends StatelessWidget {
  const _Marcador({required this.rotulo, required this.cor});

  final String rotulo;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      alignment: Alignment.center,
      color: cor,
      child: Text(
        rotulo,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'monospace',
          fontSize: 11,
        ),
      ),
    );
  }
}

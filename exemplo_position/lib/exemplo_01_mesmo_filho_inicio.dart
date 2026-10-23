// exemplo_01_mesmo_filho_inicio.dart
// Ponto de partida: um palco, um pai, um quadradinho.
// Repare no `quadradinho`: ele não tem nenhuma propriedade de posição. Só cor e
// tamanho. Mesmo assim ele apareceu no meio do palco.
//
// Quem colocou ele ali?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaMesmoFilho()));

// * O filho da história. Nenhuma propriedade de "posição": só cor e tamanho.
const Widget quadradinho = SizedBox(
  width: 44,
  height: 44,
  child: ColoredBox(color: Colors.deepPurple),
);

class TelaMesmoFilho extends StatelessWidget {
  const TelaMesmoFilho({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mesmo filho, pais diferentes')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Text(
              'O quadrado roxo não sabe onde está.',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: _Palco(
                rotulo: 'Center',
                pai: Center(child: quadradinho),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Um "palco" é apenas uma caixa com borda, para que a posição do filho dentro
// dela fique visível. O widget `pai` é quem posiciona.
class _Palco extends StatelessWidget {
  const _Palco({required this.rotulo, required this.pai});

  final String rotulo;
  final Widget pai;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          rotulo,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.grey.shade100,
            ),
            // O `pai` recebe todo o espaço do palco e decide o offset do
            // quadradinho dentro dele.
            child: pai,
          ),
        ),
      ],
    );
  }
}

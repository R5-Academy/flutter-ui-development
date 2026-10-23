// exemplo_02_boxfit_inicio.dart
// Ponto de partida: a miniatura do produto na lista de pedidos. A caixa é
// quadrada (120x120) e a foto é larga (400x300).
//
// ! Rode e olhe: a foto encolheu para caber e sobraram duas faixas cinzas, em
// ! cima e embaixo. Numa lista de dez pedidos isso vira um serrilhado feio.
// ! O que a gente quer é a foto PREENCHENDO a caixa.
//
// A imagem sozinha não decide isso. Quem decide é um parâmetro do `Image`.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaDoBoxFit()));

// Imagem larga (400x300) numa caixa quadrada: é justamente esse descasamento
// que faz cada opção se comportar de um jeito diferente.
const _url = 'https://picsum.photos/400/300';

// Contain
// 120 / 400 = 0,3
// 400 * 0,3 = 120
// 300 * 0.3 = 90

// Cover
// 120 / 400 = 0,3
// 400 * 0,3 = 120 -> OK
// 300 * 0.3 = 90 -> 30px X

// 120 / 300 = 0,4
// 400 * 0,4 = 160 -> OK Ficou maior (40px cortar 20px de cada lado )
// 300 * 0,4 = 120 -> OK

class TelaDoBoxFit extends StatelessWidget {
  const TelaDoBoxFit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BoxFit')),
      body: SingleChildScrollView(
        padding: .all(16),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _CaixaFit(.scaleDown),
            _CaixaFit(.cover),
            _CaixaFit(.contain),
            _CaixaFit(.fill),
            _CaixaFit(.fitWidth),
            _CaixaFit(.fitHeight),
            _CaixaFit(.none),
          ],
        ),
      ),
    );
  }
}

// * A caixa tem tamanho fixo. A imagem tem outro. O encontro dos dois é o
// * assunto da aula.
class _CaixaFit extends StatelessWidget {
  final BoxFit fit;

  const _CaixaFit(this.fit);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey),
            color: Colors.blueGrey.withValues(alpha: 0.1),
          ),
          // ClipRect impede a imagem de vazar para fora da caixa.
          child: ClipRect(
            child: Image.network(
              _url,
              fit: fit,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        // Sem passar nada, vale o padrão. O nome dele está aqui embaixo — e é
        // ele que produziu as faixas cinzas.
        Text('$fit', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

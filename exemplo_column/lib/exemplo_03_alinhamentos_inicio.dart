// exemplo_03_alinhamentos_inicio.dart
// Ponto de partida: uma Column dentro de um palco de altura fixa, com os
// alinhamentos no padrão (start / center).
//
// * O palco tem altura fixa de propósito: mainAxisAlignment só tem efeito
// * visível quando SOBRA espaço no eixo principal. Sem folga vertical, todos os
// * valores ficariam iguais ao start.
//
// Repare na sobra cinza embaixo — é ela que o eixo principal distribui.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: Alinhamentos()));

class Alinhamentos extends StatelessWidget {
  const Alinhamentos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Column: alinhamentos')),
      body: const Center(
        child: _Palco(
          rotulo: 'start / center\n(os padrões)',
          main: MainAxisAlignment.start,
          cross: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}

// Um palco de tamanho fixo com uma Column dentro, para comparar alinhamentos.
class _Palco extends StatelessWidget {
  const _Palco({
    required this.rotulo,
    required this.main,
    this.cross = CrossAxisAlignment.center,
  });

  final String rotulo;
  final MainAxisAlignment main;
  final CrossAxisAlignment cross;

  @override
  Widget build(BuildContext context) {
    return Column(
      // O palco abraça o próprio conteúdo (o quadro + o rótulo).
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 110,
          height: 240,
          child: ColoredBox(
            color: Colors.grey.shade300,
            child: Column(
              mainAxisAlignment: main,
              crossAxisAlignment: cross,
              children: const [
                _Bloco(cor: Colors.red),
                _Bloco(cor: Colors.green),
                _Bloco(cor: Colors.blue),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 110,
          child: Text(
            rotulo,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
          ),
        ),
      ],
    );
  }
}

class _Bloco extends StatelessWidget {
  const _Bloco({required this.cor});

  final Color cor;

  @override
  Widget build(BuildContext context) {
    return Container(width: 60, height: 36, color: cor);
  }
}

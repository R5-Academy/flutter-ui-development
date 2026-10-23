// exemplo_04_ordem_inicio.dart
// Ponto de partida: três discos sobrepostos, na ordem vermelho, verde, azul.
//
// * O AZUL está na frente. Ninguém escreveu isso em lugar nenhum — não existe
// * uma propriedade `z` no Flutter.
//
// Quem manda é a POSIÇÃO na lista `children`: o primeiro é pintado primeiro
// (fica atrás), o último é pintado por último (fica na frente).

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: OrdemDasCamadas()));

class OrdemDasCamadas extends StatelessWidget {
  const OrdemDasCamadas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ordem = camadas (z)')),
      body: const Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            _Disco(
              cor: Colors.red,
              margin: EdgeInsets.only(right: 80, bottom: 80),
            ),
            _Disco(cor: Colors.green, margin: EdgeInsets.zero),
            _Disco(
              cor: Colors.blue,
              margin: EdgeInsets.only(left: 80, top: 80),
            ),
          ],
        ),
      ),
    );
  }
}

class _Disco extends StatelessWidget {
  const _Disco({required this.cor, required this.margin});

  final Color cor;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: cor.withValues(alpha: 0.85),
        shape: BoxShape.circle,
      ),
    );
  }
}

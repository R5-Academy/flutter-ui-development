// exemplo_01_dezesseis_por_nove_inicio.dart
// Ponto de partida: o frame de um vídeo, sem formato definido.
//
// ! O Container não tem tamanho próprio e o Align passa constraints loose (ele
// ! deixa o filho escolher). Sem nada mandando um formato, o Container abraça o
// ! filho e vira o 64x64 do ícone. Nada parecido com uma thumbnail de vídeo.
//
// Poderíamos cravar `height: 200`... mas aí quebraria em telas de larguras
// diferentes. O que queremos não é um tamanho, é um FORMATO.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaThumbnail()));

class TelaThumbnail extends StatelessWidget {
  const TelaThumbnail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AspectRatio 16/9')),
      body: const Align(
        alignment: Alignment.topCenter,
        child: Padding(padding: EdgeInsets.all(16), child: _FrameDoVideo()),
      ),
    );
  }
}

// O placeholder de mídia (o frame do vídeo).
class _FrameDoVideo extends StatelessWidget {
  const _FrameDoVideo();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: const Icon(Icons.play_circle_fill, color: Colors.white, size: 64),
    );
  }
}

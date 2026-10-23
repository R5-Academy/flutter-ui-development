// exemplo_02_maxlines_overflow_inicio.dart
// Ponto de partida: um título longo numa caixa de 260px, sem tratamento.
//
// O Text não estoura — ele quebra em quantas linhas precisar. Num card de
// lista, porém, isso empurra todo o resto para baixo e destrói o alinhamento
// entre os itens.
//
// Queremos limitar a quantas linhas ele pode ocupar.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoOverflow()));

class DemoOverflow extends StatelessWidget {
  const DemoOverflow({super.key});

  static const _frase =
      'Este é um título bastante longo que definitivamente não cabe em uma '
      'única linha estreita';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        // Largura limitada de propósito, para o texto ter onde estourar.
        child: SizedBox(
          width: 260,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('sem maxLines: quebra em quantas linhas precisar'),
              SizedBox(height: 8),
              Text(_frase),
            ],
          ),
        ),
      ),
    );
  }
}

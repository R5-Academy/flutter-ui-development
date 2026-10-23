// exemplo_02_ancoras_inicio.dart
// Ponto de partida: um palco de tamanho fixo com UMA âncora — o centro.
//
// O par (0, 0) do Alignment.center é a pista do sistema de coordenadas desta
// aula: a origem NÃO fica no canto, fica no MEIO.
//
// A partir daqui marcamos as outras oito.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaAncoras()));

const double ladoPalco = 280;

class TelaAncoras extends StatelessWidget {
  const TelaAncoras({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('As 9 âncoras')),
      // O Align de fora só centraliza o palco na tela — e é o próprio widget da
      // aula: sem alignment, o padrão dele já é o centro.
      body: Align(
        child: Container(
          width: ladoPalco,
          height: ladoPalco,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border.all(color: Colors.grey),
          ),
          // * O Align ocupa o palco todo (278x278 — 280 menos a borda de 1px de
          // * cada lado) e usa o espaço livre (palco menos filho) para encostar
          // * a caixinha na âncora.
          child: const Align(
            alignment: Alignment.center,
            child: _Marcador(rotulo: '0,0'),
          ),
        ),
      ),
    );
  }
}

class _Marcador extends StatelessWidget {
  const _Marcador({required this.rotulo});

  final String rotulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      alignment: Alignment.center,
      color: Colors.deepPurple,
      child: Text(
        rotulo,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'monospace',
          fontSize: 12,
        ),
      ),
    );
  }
}

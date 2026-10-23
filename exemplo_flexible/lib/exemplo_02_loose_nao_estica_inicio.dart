// exemplo_02_loose_nao_estica_inicio.dart
// Ponto de partida: o MESMO Flexible do bloco anterior, agora com um filho
// CURTO — só um "Oi".
//
// ! Repare: a barra teal ficou curtinha e sobrou espaço vazio na Row. O
// ! Flexible não esticou o filho.
//
// * Isso é o `fit` padrão em ação: FlexFit.loose. O filho recebe uma constraint
// * com PISO ZERO e teto igual ao espaço disponível -> [min: 0, max: espaço].
// * Como o piso é 0, o filho PODE ser menor que o espaço — e encolhe até o
// * próprio conteúdo.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaLoose()));

class TelaLoose extends StatelessWidget {
  const TelaLoose({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('loose não estica')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            // fit: FlexFit.loose é o padrão — nem precisa escrever.
            Flexible(child: _Barra('Oi', Colors.teal)),
          ],
        ),
      ),
    );
  }
}

class _Barra extends StatelessWidget {
  const _Barra(this.texto, this.cor);

  final String texto;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cor,
      padding: const EdgeInsets.all(16),
      child: Text(texto, style: const TextStyle(color: Colors.white)),
    );
  }
}

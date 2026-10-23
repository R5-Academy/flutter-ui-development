// exemplo_04_flex_factor_inicio.dart
// Ponto de partida: o flex factor também existe no Flexible.
//
// * Dois Flexible com flex: 2 e flex: 1, e textos LONGOS nos dois. A proporção
// * 2:1 aparece direitinho: o primeiro fica com o dobro da largura e quebra em
// * menos linhas.
//
// Parece igual ao Expanded do bloco anterior. Mas há uma pegadinha do loose que
// só aparece quando o conteúdo é curto.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaFlexFactor()));

class TelaFlexFactor extends StatelessWidget {
  const TelaFlexFactor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('flex factor com loose')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Textos longos: flex 2 : 1 (o teto muda, dá pra ver):'),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // * flex: 2 -> teto = 2/3 do espaço. O texto é longo, então usa
                // * o teto todo: fica com o dobro da largura do vizinho.
                Flexible(
                  flex: 2,
                  child: _Bloco(
                    'Descrição longa do produto que ocupa bastante espaço na '
                    'linha',
                    Colors.indigo,
                  ),
                ),
                SizedBox(width: 8),
                Flexible(
                  child: _Bloco(
                    'Texto secundário também comprido',
                    Colors.teal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Bloco extends StatelessWidget {
  const _Bloco(this.texto, this.cor);

  final String texto;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cor,
      padding: const EdgeInsets.all(12),
      child: Text(texto, style: const TextStyle(color: Colors.white)),
    );
  }
}

// exemplo_02_flex_proporcional_inicio.dart
// Ponto de partida: dois Expanded na mesma Row.
//
// * Cada um pegou metade. Nenhum dos dois pediu isso — o `flex` padrão é 1 para
// * os dois, então eles empatam.
//
// E se um deles precisar do dobro do outro?

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaFlexProporcional()));

class TelaFlexProporcional extends StatelessWidget {
  const TelaFlexProporcional({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('flex proporcional')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('1 : 1  (ambos flex: 1, o padrão) -> metade cada'),
            SizedBox(height: 8),
            Row(
              children: [
                // flex padrão é 1, então nem precisa escrever.
                Expanded(child: _Painel('flex 1', Colors.teal)),
                Expanded(child: _Painel('flex 1', Colors.deepPurple)),
              ],
            ),

            SizedBox(height: 20),

            Text('2 : 1  O primeiro fica com o DOBRO (2/3 e 1/3)'),
            SizedBox(height: 8),
            Row(
              children: [
                // flex padrão é 1, então nem precisa escrever.
                Expanded(flex: 2, child: _Painel('flex 1', Colors.teal)),
                Expanded(child: _Painel('flex 1', Colors.deepPurple)),
              ],
            ),

            SizedBox(height: 20),

            Text('2 : 1 : 1  -> 2/4, 1/4, 1/4'),
            SizedBox(height: 8),
            Row(
              children: [
                // flex padrão é 1, então nem precisa escrever.
                Expanded(flex: 2, child: _Painel('flex 1', Colors.teal)),
                Expanded(child: _Painel('flex 1', Colors.deepPurple)),
                Expanded(child: _Painel('flex 1', Colors.orange)),
              ],
            ),
            SizedBox(height: 24),

            Text('Com um filho fixo no meio: o flex divide o que sobra'),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(flex: 2, child: _Painel('flex 2', Colors.teal)),
                SizedBox(
                  width: 100,
                  height: 64,
                  child: Center(child: Text('fixo 100px')),
                ),
                Expanded(child: _Painel('flex 1', Colors.deepPurple)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Bloco colorido reutilizado nas Rows, só para enxergar a fatia de cada um.
class _Painel extends StatelessWidget {
  const _Painel(this.rotulo, this.cor);

  final String rotulo;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      alignment: Alignment.center,
      color: cor,
      child: Text(
        rotulo,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

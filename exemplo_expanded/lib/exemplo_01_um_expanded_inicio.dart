// exemplo_01_um_expanded_inicio.dart
// Ponto de partida: uma Row com ícone, uma barra e um botão.
//
// ! A barra do meio encolheu até o tamanho do próprio texto. Como o
// ! mainAxisAlignment padrão é `start`, os três filhos ficaram grudados à
// ! ESQUERDA e o vazio sobrou todo à direita, DEPOIS do botão. Queríamos a
// ! barra ocupando esse espaço e o botão encostado na borda direita.
//
// Nas aulas de Row e Column, todo filho escolhia o próprio tamanho: a Row passa
// largura ilimitada no eixo principal e aceita o que o filho pedir. Aqui
// precisamos do contrário: um filho que aceite o tamanho que o pai mandar.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaUmExpanded()));

class TelaUmExpanded extends StatelessWidget {
  const TelaUmExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Um Expanded ocupa o resto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('A barra do meio tem só a largura do texto:'),
            const SizedBox(height: 16),
            Row(
              children: [
                // Filho FIXO: pede só a largura do próprio ícone.
                const Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 8),
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('só a minha largura'),
                ),
                const SizedBox(width: 8),
                // Filho FIXO: o botão pede só a largura do próprio conteúdo.
                FilledButton(onPressed: () {}, child: const Text('Ir')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

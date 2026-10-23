// exemplo_02_barra_de_acoes_inicio.dart
// Ponto de partida: a confirmação de exclusão de uma conversa. Duas saídas:
// cancelar ou excluir.
//
// ! Os dois botões estão idênticos. E aqui isso não é só feio — é perigoso.
//
// ! Numa caixa de confirmação, muita gente toca no botão da direita por
// ! reflexo, sem ler. Quando os dois têm o mesmo peso, nada avisa que um deles
// ! apaga a conversa PARA SEMPRE e o outro não faz nada.
//
// A hierarquia de ênfase existe justamente para o olho decidir antes da
// leitura. Aqui ela está achatada.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: BarraDeAcoes()));

class BarraDeAcoes extends StatelessWidget {
  const BarraDeAcoes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barra de ações')),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Excluir conversa?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                const Text('Essa ação não pode ser desfeita.'),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton(
                      onPressed: () => debugPrint('cancelou'),
                      child: const Text('Cancelar'),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () => debugPrint('excluiu'),
                      child: const Text('Excluir'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// exemplo_03_alvo_de_toque_inicio.dart
// Ponto de partida: o rodapé de uma tela de cadastro, com três links de ação.
//
// ! Rode e tente responder sem clicar: onde termina um botão e começa o outro?
//
// ! O TextButton não tem fundo nem borda. Na tela existe uma caixa que responde
// ! ao toque, mas você não vê nenhuma pista de onde ela está — só as letras.
// ! Aqui os três estão colados, sem nada entre eles.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: AlvoDeToque()));

class AlvoDeToque extends StatelessWidget {
  const AlvoDeToque({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alvo de toque')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ao criar a conta você concorda com:',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => debugPrint('termos'),
                    child: const Text('Termos'),
                  ),
                  TextButton(
                    onPressed: () => debugPrint('privacidade'),
                    child: const Text('Privacidade'),
                  ),
                  TextButton(
                    onPressed: () => debugPrint('ajuda'),
                    child: const Text('Ajuda'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

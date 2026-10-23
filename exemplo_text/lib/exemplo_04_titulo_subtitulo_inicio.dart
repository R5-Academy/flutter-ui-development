// exemplo_04_titulo_subtitulo_inicio.dart
// Ponto de partida: o card de produto com os três textos no lugar — e nenhum
// estilo.
//
// ! Título, descrição e preço saem exatamente iguais. Não dá para saber o que é
// ! mais importante batendo o olho, e a descrição longa empurra o preço para
// ! longe.
//
// Este bloco junta tudo o que a aula viu: peso, tamanho, cor, height, maxLines
// e ellipsis, num componente com cara de app.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoCard()));

class DemoCard extends StatelessWidget {
  const DemoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Fone de ouvido Bluetooth com cancelamento de ruído'),
              SizedBox(height: 4),
              Text(
                '30 horas de bateria, conexão multiponto e estojo de recarga '
                'rápida.',
              ),
              SizedBox(height: 12),
              Text(r'R$ 349,90'),
            ],
          ),
        ),
      ),
    );
  }
}

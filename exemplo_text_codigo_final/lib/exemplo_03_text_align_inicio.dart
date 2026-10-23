// exemplo_03_text_align_inicio.dart
// Ponto de partida: um Text com `textAlign: TextAlign.center`.
//
// ! E ele NÃO centralizou nada. O fundo amarelo mostra por quê: a caixa do Text
// ! abraça exatamente o texto, então não há espaço vazio para onde alinhar.
//
// * A pegadinha da aula: `textAlign` alinha o texto DENTRO da caixa dele. Se a
// * caixa tem o tamanho do texto, não existe "dentro" sobrando.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DemoAlign()));

class DemoAlign extends StatelessWidget {
  const DemoAlign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.amber.shade100,
              child: const Text('center sem largura', textAlign: .center),
            ),

            SizedBox(height: 24),
            Container(
              width: double.infinity,
              color: Colors.lightGreen.shade100,
              child: const Text('center sem largura', textAlign: .center),
            ),

            SizedBox(height: 24),

            Container(
              width: 320,
              color: Colors.lightBlue.shade100,
              child: const Text(
                'Um parágrafo justificado estica os espaços entre as palavras '
                'para alinhas as duas margens',
                textAlign: .justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

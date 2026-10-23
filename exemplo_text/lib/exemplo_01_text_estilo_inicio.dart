// exemplo_01_text_estilo_inicio.dart
// Ponto de partida: quatro textos, nenhum estilo.
//
// Repare que eles NÃO saem sem estilo nenhum: saem com fontSize 14, peso w400,
// letterSpacing 0.25 e entrelinha 1.43. Esse estilo vem do DefaultTextStyle que
// o Material (todo Scaffold é um) instala a partir do textTheme.bodyMedium do
// tema. É por isso que o parágrafo já respira um pouco.
//
// O que falta é HIERARQUIA: os quatro são iguais, então o título não parece
// título e o texto que deveria estar riscado está igual aos outros. Tudo isso se
// resolve com um único parâmetro: `style`.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoEstilo()));

class DemoEstilo extends StatelessWidget {
  const DemoEstilo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        // Palco de 320 de propósito: o parágrafo tem que quebrar em mais de uma
        // linha em qualquer tela, senão a entrelinha não tem como aparecer.
        child: SizedBox(
          width: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Texto padrão (sem style)'),
              SizedBox(height: 16),
              Text('Título medium (w500)'),
              SizedBox(height: 16),
              Text(
                'Um parágrafo com respiro entre as linhas. O height controla a '
                'entrelinha como multiplicador do fontSize, não em pixels.',
              ),
              SizedBox(height: 16),
              Text('Riscado e itálico'),
            ],
          ),
        ),
      ),
    );
  }
}

// exemplo_01_elevatedbutton_minimo_inicio.dart
// Ponto de partida: um "botão" desenhado na mão — um Container com cor, cantos
// arredondados, sombra e um texto branco no meio.
//
// ! Parece um botão. Mas:
// !   - toque: não acontece nada, e nem tem aquele efeito de tinta se espalhando;
// !   - não existe jeito de deixá-lo desabilitado;
// !   - o leitor de tela não vê botão nenhum aqui. Medido na árvore de
// !     semântica: isButton = false e nenhuma ação de toque. Com o
// !     ElevatedButton no lugar, isButton = true e a ação de toque aparece;
// !   - a cor e a sombra foram escolhidas por nós, não pelo tema.
//
// Botão não é uma caixa bonita. É um contrato: aparência, feedback de toque,
// estado desabilitado e semântica — tudo junto.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: BotaoMinimo()));

class BotaoMinimo extends StatelessWidget {
  const BotaoMinimo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ElevatedButton mínimo')),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Text(
            'Pressione aqui',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// exemplo_02_timing_e_posicao_inicio.dart
// Ponto de partida: dois tooltips no comportamento padrão. Rode no Chrome, que
// é onde os dois problemas aparecem.
//
// ! 1. Passe o mouse RÁPIDO por cima do relógio, indo para outro lugar da tela.
// !    A dica pisca. Agora imagine uma barra com oito ícones: atravessar a barra
// !    com o mouse acende e apaga oito balões em sequência.
//
// ! 2. O ícone de baixo tem uma legenda logo abaixo dele. Passe o mouse: a dica
// !    abre para baixo (é o padrão) e COBRE justamente o texto que a pessoa
// !    estava lendo.
//
// Os dois são ajuste fino — e é o que separa uma dica que ajuda de uma que
// atrapalha.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TimingEPosicao()));

class TimingEPosicao extends StatelessWidget {
  const TimingEPosicao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timing e posição')),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 40,
          children: [
            Tooltip(
              message: 'Histórico de alterações',
              child: Icon(Icons.timer, size: 40),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Tooltip(
                  message: 'Enviar para o topo da fila',
                  child: Icon(Icons.arrow_upward, size: 40),
                ),
                SizedBox(height: 8),
                Text('Prioridade atual: normal'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

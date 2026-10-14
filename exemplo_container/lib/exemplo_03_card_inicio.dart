// exemplo_03_card_inicio.dart
// Ponto de partida: a caixa estilizada do bloco anterior, com um texto de
// verdade dentro.
//
// O texto está grudado na borda do card, e o card está grudado no canto da tela
// (sem alignment ele encolheu no filho, e o body o posicionou em 0,0 — é o
// exemplo_01_03 de novo, agora num card de verdade).
//
// Faltam os dois espaçamentos do Container — e eles NÃO são a mesma coisa. Mede-se
// a diferença no branco:
//   agora         -> branco 239x52 no canto (0,0)
//   + padding 20  -> branco 279x92, ainda em (0,0)   ... o padding CRESCE o branco
//   + margin 24   -> branco 279x92, agora em (24,24) ... a margin DESLOCA o branco
//
// ! Não embrulhe este card num Center para "ficar bonito". Dentro de um Center a
// ! margin fica INVISÍVEL: o Center recentra a caixa maior e o branco não muda
// ! nem de tamanho nem de lugar. Precisamos do card encostado em algo para que a
// ! margin tenha o que empurrar.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoCard()));

class DemoCard extends StatelessWidget {
  const DemoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: const Text(
          'Plano Premium\nR\$ 29,90/mês',
          style: TextStyle(fontSize: 18, height: 1.4),
        ),
      ),
    );
  }
}

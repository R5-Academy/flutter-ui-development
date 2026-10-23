// exemplo_01_tamanho_fixo_inicio.dart
// Ponto de partida: um ColoredBox sem tamanho próprio, dentro de um Center.
//
// O Center manda constraint LOOSE (de 0 até o disponível). O ColoredBox não tem
// filho nem tamanho, então escolhe o mínimo: 0x0. Ele sumiu da tela.
//
// Falta alguém dizer o tamanho.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TamanhoFixo()));

class TamanhoFixo extends StatelessWidget {
  const TamanhoFixo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SizedBox: tamanho fixo')),
      body: const Center(child: ColoredBox(color: Colors.indigo)),
    );
  }
}

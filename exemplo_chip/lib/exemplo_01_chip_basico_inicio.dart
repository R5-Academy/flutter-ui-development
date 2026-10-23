// exemplo_01_chip_basico_inicio.dart
// Ponto de partida: o campo "Convidados" de um formulário de evento. A Ana já
// foi adicionada e aparece como um `Chip` — um bloco compacto com a inicial e o
// nome.
//
// ! Agora tente tirar a Ana da lista. Não dá: o chip não tem o "x".
//
// ? Procure na API do Chip um parâmetro tipo `mostrarBotaoRemover`. Não existe.
// ? O que faz o "x" aparecer é outra coisa — e a escolha do Flutter aqui diz
// ? muito sobre como o widget pensa.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: ChipBasico()));

class ChipBasico extends StatelessWidget {
  const ChipBasico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Convidados')),
      body: const Center(
        child: Chip(
          // avatar: fica à esquerda do label. Aqui, a inicial do contato.
          avatar: CircleAvatar(child: Text('A')),
          label: Text('Ana Souza'),
        ),
      ),
    );
  }
}

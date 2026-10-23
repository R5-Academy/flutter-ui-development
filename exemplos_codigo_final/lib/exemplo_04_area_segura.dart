// exemplo_04_area_segura.dart
// Demonstra: o Scaffold NÃO embrulha o body num SafeArea.
// Novo em relação ao 03: a tela roda sem appBar, então o body começa em y = 0 —
// ou seja, embaixo do relógio, da bateria e do notch.

import 'package:flutter/material.dart';

void main() => runApp(const AppAreaSegura());

class AppAreaSegura extends StatelessWidget {
  const AppAreaSegura({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Área segura', home: TelaAreaSegura());
  }
}

class TelaAreaSegura extends StatefulWidget {
  const TelaAreaSegura({super.key});

  @override
  State<TelaAreaSegura> createState() => _TelaAreaSeguraState();
}

class _TelaAreaSeguraState extends State<TelaAreaSegura> {
  bool _comSafeArea = false;

  @override
  Widget build(BuildContext context) {
    // O que o sistema reserva nas bordas (barra de status, notch, gestos).
    final areaReservada = MediaQuery.paddingOf(context);

    // Filho único do body, sem Center: o body alinha no topo à esquerda por
    // padrão, então este texto encosta na borda superior da tela.
    final conteudo = Text(
      'SafeArea: ${_comSafeArea ? "ligado" : "desligado"}\n\n'
      'reservado no topo: ${areaReservada.top.toStringAsFixed(1)}\n'
      'reservado na base: ${areaReservada.bottom.toStringAsFixed(1)}\n\n'
      'Sem appBar, o body começa em y = 0.\n'
      'Ligue o SafeArea e veja o texto descer.',
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      // ! Sem appBar e sem barra inferior, nenhuma peça protege as bordas:
      // ! o conteúdo entra debaixo da barra de status e da barra de gestos.
      // * O Scaffold não esconde essa informação — ele mantém o padding no
      // * MediaQuery justamente para você decidir com um SafeArea.
      body: _comSafeArea ? SafeArea(child: conteudo) : conteudo,
      persistentFooterButtons: [
        TextButton(
          onPressed: () => setState(() => _comSafeArea = !_comSafeArea),
          child: const Text('ligar/desligar SafeArea'),
        ),
      ],
    );
  }
}

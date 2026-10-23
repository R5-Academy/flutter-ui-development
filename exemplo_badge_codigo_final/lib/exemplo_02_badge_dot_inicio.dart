// exemplo_02_badge_dot_inicio.dart
// Ponto de partida: a barra de atalhos do app — e-mail, chat e notificações.
//
// O e-mail tem mensagem nova. O chat também. E o `Badge.count` do bloco
// anterior não serve para nenhum dos dois.
//
// ! O motivo: nem todo aviso tem número. O servidor de e-mail responde "tem
// ! coisa nova desde a última sincronização", não "tem 3". Inventar um número
// ! para preencher o `count` seria mentir para o usuário.
//
// ! E o terceiro caso é o oposto: notificações está em dia. Nada a avisar.
//
// Faltam dois modos que o Badge tem e o `Badge.count` esconde.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaDot()));

class TelaDot extends StatelessWidget {
  const TelaDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Atalhos')),
      body: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Tem mensagem nova — e não sabemos quantas.
            Badge(label: Text('Qualquer'), child: Icon(Icons.email, size: 40)),
            // Tem conversa nova — e também não sabemos quantas.
            Badge(
              backgroundColor: Colors.green,
              child: Icon(
                Icons.chat_bubble,
                size: 40,
                semanticLabel: 'Conversas, tem mensagem nova',
              ),
            ),
            // Está em dia: nada a avisar.
            Badge(
              label: Text('0'),
              isLabelVisible: false,
              child: Icon(Icons.notifications, size: 40),
            ),
          ],
        ),
      ),
    );
  }
}

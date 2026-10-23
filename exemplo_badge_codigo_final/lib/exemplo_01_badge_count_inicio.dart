// exemplo_01_badge_count_inicio.dart
// Ponto de partida: o sino de notificações da tela inicial. E, logo abaixo, o
// dado que o app já tem: oito notificações não lidas.
//
// ! O número está numa linha de texto perdida no meio da tela. O ícone — que é
// ! onde a pessoa realmente olha — não conta nada.
//
// A informação precisa estar GRUDADA no ícone. E, antes de você pensar em
// `Stack` com `Positioned`, o Material 3 tem um widget pronto para isso.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaBadge()));

const _naoLidas = 8;

class TelaBadge extends StatelessWidget {
  const TelaBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notificações')),
      body: Center(
        child: Badge.count(
          count: _naoLidas,
          child: Icon(
            Icons.notifications,
            size: 48,
            semanticLabel: 'Notificações não lidas',
          ),
        ),
        // child: Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Icon(Icons.notifications, size: 48),
        //     SizedBox(height: 24),
        //     Text('$_naoLidas notificações não lidas'),
        //   ],
        // ),
      ),
    );
  }
}

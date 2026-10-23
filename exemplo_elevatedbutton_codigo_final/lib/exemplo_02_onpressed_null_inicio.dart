// exemplo_02_onpressed_null_inicio.dart
// Ponto de partida: a última etapa de um cadastro. A pessoa precisa aceitar os
// termos antes de continuar.
//
// ! Rode e toque em "Continuar" sem marcar nada. Ele continua. A regra existe no
// ! texto da tela e em lugar nenhum do código.
//
// ? Procure um parâmetro `enabled` no ElevatedButton. Não existe.
//
// O Flutter resolve isso de um jeito que parece estranho na primeira vez — e
// que, depois que cai a ficha, você reconhece em toda a biblioteca.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: BotaoDesabilita()));

class BotaoDesabilita extends StatefulWidget {
  const BotaoDesabilita({super.key});

  @override
  State<BotaoDesabilita> createState() => _BotaoDesabilitaState();
}

class _BotaoDesabilitaState extends State<BotaoDesabilita> {
  // Estado do formulário: a pessoa aceitou os termos?
  bool _aceitouTermos = false;

  void _continuar() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Seguindo em frente...')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: const Text('Aceito os termos'),
              value: _aceitouTermos,
              onChanged: (v) => setState(() => _aceitouTermos = v),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              // ! Sempre habilitado, aceitando os termos ou não.
              onPressed: _aceitouTermos ? _continuar : null,
              child: const Text('Continuar'),
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              // ! Sempre habilitado, aceitando os termos ou não.
              onPressed: null,
              child: const Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}

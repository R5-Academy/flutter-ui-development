// exemplo_01_divider_basico_inicio.dart
// Ponto de partida: a tela de resumo de um pedido, com três seções — o pedido,
// o pagamento e o endereço.
//
// ! As três estão empilhadas sem nenhuma fronteira entre elas. O negrito dos
// ! títulos ajuda, mas o olho ainda precisa de esforço para saber onde uma
// ! seção termina e a outra começa.
//
// Dá para resolver isso com mais espaçamento. Mas espaço é ambíguo — o Material
// tem um widget que diz "acabou aqui" de forma explícita.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DividerBasico()));

class DividerBasico extends StatelessWidget {
  const DividerBasico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resumo do pedido')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sobre o pedido',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            Text('3 itens · entrega em até 40 minutos'),

            Divider(),

            Text(
              'Pagamento',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            Text('Cartão de crédito · final 4321'),

            Divider(),

            Text(
              'Endereço',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            Text('Rua das Flores, 123 · Centro'),
          ],
        ),
      ),
    );
  }
}

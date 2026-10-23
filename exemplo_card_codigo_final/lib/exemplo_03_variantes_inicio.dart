// exemplo_03_variantes_inicio.dart
// Ponto de partida: a tela de resumo da conta, com três blocos de informação de
// importância bem diferente — o destaque, o dado secundário e o rodapé legal.
//
// ! Os três são `Card`, então os três têm exatamente a mesma cor e a mesma
// ! sombra. Nada na tela diz o que importa mais: o aviso de rodapé tem o mesmo
// ! peso visual que o saldo.
//
// Nem toda superfície precisa de sombra. O Material 3 tem três variantes de
// Card, e a escolha entre elas é justamente uma escolha de PESO.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Variantes()));

class Variantes extends StatelessWidget {
  const Variantes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: const Text('Variantes de Card')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: _Conteudo(
                titulo: r'Saldo: R$ 1.240,00',
                legenda: 'o número que a pessoa abriu o app para ver',
              ),
            ),
            SizedBox(height: 12),
            Card.filled(
              child: _Conteudo(
                titulo: 'Última fatura',
                legenda: 'informação de apoio, consultada de vez em quando',
              ),
            ),
            SizedBox(height: 12),
            Card.outlined(
              child: _Conteudo(
                titulo: 'Aviso',
                legenda: 'texto legal que quase ninguém lê',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Conteudo extends StatelessWidget {
  const _Conteudo({required this.titulo, required this.legenda});

  final String titulo;
  final String legenda;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            legenda,
            style: TextStyle(color: Colors.black.withValues(alpha: 0.6)),
          ),
        ],
      ),
    );
  }
}

// exemplo_02_elevation_inicio.dart
// Ponto de partida: quatro cartões empilhados numa tela.
//
// ! Os quatro têm exatamente o mesmo peso visual — a mesma sombra, a mesma
// ! altura aparente. Olhando de longe, nada diz qual deles importa mais.
//
// Numa tela real, "esse aqui está em destaque" e "esse é só um item da lista"
// precisam ser distinguíveis sem ler uma palavra. O Card tem um parâmetro para
// isso.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Elevacoes()));

class Elevacoes extends StatelessWidget {
  const Elevacoes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: const Text('Elevation')),
      body: ListView(
        padding: const .all(16),
        children: const [
          _Cartao(elevation: 0),
          _Cartao(elevation: 1),
          _Cartao(elevation: 4),
          _Cartao(elevation: 12),
        ],
      ),
    );
  }
}

class _Cartao extends StatelessWidget {
  final double elevation;

  const _Cartao({required this.elevation});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      child: SizedBox(
        height: 72,
        child: Center(
          child: Text(
            'cartão',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

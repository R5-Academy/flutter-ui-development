// exemplo_01_centralizar_inicio.dart
// Ponto de partida: um card solto no body.
//
// Como sempre, sem ninguém posicionando ele cola no topo-esquerda. Já sabemos
// resolver isso com Align — e existe um atalho ainda mais curto.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DemoCentralizar()));

class DemoCentralizar extends StatelessWidget {
  const DemoCentralizar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(child: const _Cartao()),
    );
  }
}

class _Cartao extends StatelessWidget {
  const _Cartao();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Text('No centro', style: TextStyle(fontSize: 20)),
    );
  }
}

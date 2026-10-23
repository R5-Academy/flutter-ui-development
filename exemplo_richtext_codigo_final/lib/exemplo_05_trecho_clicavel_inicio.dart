// exemplo_05_trecho_clicavel_inicio.dart
// Ponto de partida: "Li e aceito os Termos de Uso", com o trecho já estilizado
// como link — azul, sublinhado, seminegrito.
//
// ! Ele PARECE clicável e não é. Toque nele: nada acontece.
//
// Estilo de link não é comportamento de link. Falta dar ao span um recognizer
// de toque.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DemoClicavel()));

class DemoClicavel extends StatefulWidget {
  const DemoClicavel({super.key});

  @override
  State<DemoClicavel> createState() => _DemoClicavelState();
}

class _DemoClicavelState extends State<DemoClicavel> {
  late final TapGestureRecognizer _abrirTermos;

  @override
  void initState() {
    super.initState();
    _abrirTermos = TapGestureRecognizer()
      ..onTap = () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Abrindo os Termos de Uso....')));
      };
  }

  @override
  void dispose() {
    _abrirTermos.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Text.rich(
            TextSpan(
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
                height: 1.4,
              ),
              children: [
                const TextSpan(text: 'Li e aceito os '),
                TextSpan(
                  text: 'Termos de Uso',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500,
                  ),
                  recognizer: _abrirTermos,
                ),
                const TextSpan(text: ' do aplicativo.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

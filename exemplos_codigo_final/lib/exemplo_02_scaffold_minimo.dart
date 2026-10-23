// exemplo_02_scaffold_minimo.dart
// Demonstra: a moldura mínima — um Scaffold com apenas o body preenchido.
// Novo em relação ao 01: o Scaffold entra e resolve fundo e texto de uma vez.

import 'package:flutter/material.dart';

void main() => runApp(const AppMinimo());

class AppMinimo extends StatelessWidget {
  const AppMinimo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Scaffold mínimo',
      home: TelaComFundoProprio(),
    );
  }
}

class TelaMinima extends StatelessWidget {
  const TelaMinima({super.key});

  @override
  Widget build(BuildContext context) {
    // * Todos os slots são opcionais. Só o body já entrega o essencial:
    // * um Material forrando a tela (fundo opaco + texto no estilo do tema)
    // * e o espaço do conteúdo calculado pelo Scaffold.
    // Repare que o construtor é const: dá para usar `const Scaffold(...)`.
    return const Scaffold(body: Center(child: Text('Olá, moldura!')));
  }
}

// * Variação para mostrar de onde vem a cor do fundo.
// Sem backgroundColor, o Scaffold usa ThemeData.scaffoldBackgroundColor
// (no Material 3 isso cai em colorScheme.surface).
class TelaComFundoProprio extends StatelessWidget {
  const TelaComFundoProprio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: const Center(child: Text('O fundo é do Scaffold, não do body')),
    );
  }
}

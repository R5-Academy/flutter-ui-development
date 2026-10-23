// exemplo_02_center_e_align_inicio.dart
// Ponto de partida: a forma geral — Align com alignment fixo no centro.
//
// É exatamente o que a aula passada ensinou. Guarde esta tela na cabeça (ou
// deixe rodando numa janela ao lado) antes de abrir o _completo.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoEquivalencia()));

class DemoEquivalencia extends StatelessWidget {
  const DemoEquivalencia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: const Align(alignment: Alignment.center, child: _Cartao()),
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

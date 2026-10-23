// exemplo_03_clampeamento_inicio.dart
// Ponto de partida: o protocolo isolado, sem NENHUM widget de layout — só a
// classe BoxConstraints.
//
// O pai não "obedece" o pedido do filho: ele CLAMPEIA (encaixa) esse pedido
// dentro dos limites. constrainWidth é literalmente essa conta.
// Aqui está só o caso frouxo. Leia a tabela antes de seguir.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaClampeamento()));

class TelaClampeamento extends StatelessWidget {
  const TelaClampeamento({super.key});

  @override
  Widget build(BuildContext context) {
    // * Constraint FROUXA e com teto: largura de 0 a 150.
    const loose = BoxConstraints(minWidth: 0, maxWidth: 150);

    // Cada linha: o filho "pede" X, o pai devolve constrainWidth(X).
    const pedidos = <double>[300, 150, 80, 10];

    return Scaffold(
      appBar: AppBar(title: const Text('O pai encaixa o pedido do filho')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'constrainWidth(pedido) = o pedido encaixado nos limites do pai',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _Tabela(
            titulo: 'LOOSE (0 a 150): corta só o que passar do teto',
            constraints: loose,
            pedidos: pedidos,
          ),
        ],
      ),
    );
  }
}

class _Tabela extends StatelessWidget {
  const _Tabela({
    required this.titulo,
    required this.constraints,
    required this.pedidos,
  });

  final String titulo;
  final BoxConstraints constraints;
  final List<double> pedidos;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        for (final double pedido in pedidos)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                SizedBox(
                  width: 130,
                  child: Text('pediu ${pedido.toStringAsFixed(0)}'),
                ),
                const Icon(Icons.arrow_forward, size: 18),
                const SizedBox(width: 12),
                Text(
                  'ficou ${constraints.constrainWidth(pedido).toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

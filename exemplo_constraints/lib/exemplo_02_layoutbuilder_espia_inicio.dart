// exemplo_02_layoutbuilder_espia_inicio.dart
// Ponto de partida: o microscópio montado, apontado para um contexto só.
// O LayoutBuilder entrega no builder exatamente o BoxConstraints que o pai
// mandou descer — dá para LER os números em vez de só ouvir a teoria.
//
// O LayoutBuilder é assunto de aula futura; hoje ele é só a lupa.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaEspia()));

// O cartão-espião: não tem tamanho próprio, só imprime a constraint recebida.
class Espiao extends StatelessWidget {
  const Espiao({super.key});

  String _formatar(double valor) =>
      valor == double.infinity ? 'infinito' : valor.toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // constraints é LITERALMENTE o que o pai mandou descer até aqui.
        return Container(
          padding: const EdgeInsets.all(12),
          color: Colors.teal.shade50,
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 13, color: Colors.black87),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'largura: ${_formatar(constraints.minWidth)} '
                  'a ${_formatar(constraints.maxWidth)}',
                ),
                Text(
                  'altura:  ${_formatar(constraints.minHeight)} '
                  'a ${_formatar(constraints.maxHeight)}',
                ),
                const SizedBox(height: 4),
                Text(
                  'isTight: ${constraints.isTight}   '
                  'tem teto (largura): ${constraints.hasBoundedWidth}',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Secao extends StatelessWidget {
  const _Secao({required this.titulo, required this.child});

  final String titulo;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        child,
        const SizedBox(height: 20),
      ],
    );
  }
}

class TelaEspia extends StatelessWidget {
  const TelaEspia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LayoutBuilder: espiando constraints')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          // Como filho de Column/ListView: largura com teto (a largura útil)
          // mas altura SEM teto -> maxHeight = infinito (unbounded).
          _Secao(
            titulo: 'Filho de Column/ListView (largura com teto, altura sem)',
            child: Espiao(),
          ),
        ],
      ),
    );
  }
}

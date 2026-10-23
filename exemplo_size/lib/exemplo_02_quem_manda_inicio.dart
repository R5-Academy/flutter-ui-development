// exemplo_02_quem_manda_inicio.dart
// As mesmas tres personalidades do exemplo anterior - agora dentro de um pai
// que manda constraint TIGHT (160x90 exatos, min == max).
//
// Rode e compare os tres tamanhos que subiram. Sao identicos.
// Cade a personalidade de cada um?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaQuemManda()));

const larguraDaArena = 160.0;
const alturaDaArena = 90.0;

class TelaQuemManda extends StatelessWidget {
  const TelaQuemManda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quem manda no tamanho?')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'O pai manda TIGHT: 160x90 exatos, minimo igual ao maximo.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Arena(
            titulo: '1. GRANDE - Container()',
            apertado: true,
            filho: Container(color: Colors.indigo),
          ),
          const Arena(
            titulo: '2. PEQUENO - SizedBox.shrink()',
            apertado: true,
            filho: SizedBox.shrink(child: ColoredBox(color: Colors.green)),
          ),
          Arena(
            titulo: '3. DO TAMANHO DO FILHO - Container(child: Text(...))',
            apertado: true,
            filho: Container(
              color: Colors.amber,
              padding: const EdgeInsets.all(6),
              child: const Text('do filho'),
            ),
          ),
        ],
      ),
    );
  }
}

// A arena controla o unico detalhe que importa aqui: se a constraint que desce
// e apertada (tight) ou frouxa (loose).
class Arena extends StatefulWidget {
  const Arena({
    super.key,
    required this.titulo,
    required this.filho,
    required this.apertado,
  });

  final String titulo;
  final Widget filho;
  final bool apertado;

  @override
  State<Arena> createState() => _ArenaState();
}

class _ArenaState extends State<Arena> {
  final _chaveDoFilho = GlobalKey();
  Size? _tamanhoQueSubiu;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _medir());
  }

  @override
  void didUpdateWidget(covariant Arena anterior) {
    super.didUpdateWidget(anterior);
    WidgetsBinding.instance.addPostFrameCallback((_) => _medir());
  }

  void _medir() {
    if (!mounted) return;
    final caixa =
        _chaveDoFilho.currentContext?.findRenderObject() as RenderBox?;
    if (caixa == null || caixa.size == _tamanhoQueSubiu) return;
    setState(() => _tamanhoQueSubiu = caixa.size);
  }

  @override
  Widget build(BuildContext context) {
    final filhoMedido = KeyedSubtree(key: _chaveDoFilho, child: widget.filho);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.titulo,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            width: larguraDaArena,
            height: alturaDaArena,
            color: Colors.grey.shade300,
            // * A unica diferenca entre os dois mundos: com Center, a
            // * constraint chega LOOSE no filho; sem ele, chega TIGHT.
            child: widget.apertado ? filhoMedido : Center(child: filhoMedido),
          ),
          const SizedBox(height: 6),
          Text(
            widget.apertado
                ? 'desceu: 160x90 TIGHT   |   SUBIU: ${_formatar(_tamanhoQueSubiu)}'
                : 'desceu: 0..160 x 0..90 LOOSE   |   SUBIU: ${_formatar(_tamanhoQueSubiu)}',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ],
      ),
    );
  }
}

String _formatar(Size? tamanho) {
  if (tamanho == null) return 'medindo...';
  final l = tamanho.width.toStringAsFixed(0);
  final a = tamanho.height.toStringAsFixed(0);
  return '$l x $a';
}

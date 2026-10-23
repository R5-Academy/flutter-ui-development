// exemplo_01_tres_personalidades_inicio.dart
// Uma arena com folga (constraint loose) e um filho dentro.
//
// O filho e um Container sem tamanho e sem child - e mesmo assim ele preencheu
// a arena inteira. Ninguem mandou ele fazer isso: foi ELE quem escolheu.
//
// Rode e leia, embaixo da arena, o tamanho que o filho devolveu para o pai.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaPersonalidades()));

const larguraDaArena = 280.0;
const alturaDaArena = 130.0;

class TelaPersonalidades extends StatelessWidget {
  const TelaPersonalidades({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tres personalidades de tamanho')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'A arena tem 280x130 e da FOLGA ao filho (constraint loose). '
            'Dentro dessa folga, quem escolhe o tamanho e o filho.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Arena(
            titulo: 'Container() - sem tamanho, sem child',
            // ! Repare que nao ha nada mandando ele ser grande. Sem child e
            // ! sem tamanho, o Container decide sozinho ocupar o maximo.
            filho: Container(color: Colors.indigo),
          ),

          Arena(
            titulo: '2. Pequeno - SizedBox.shink()',
            filho: SizedBox.shrink(child: ColoredBox(color: Colors.indigo)),
          ),

          Arena(
            titulo: '3. Tamanho do filho',
            filho: Container(
              color: Colors.amber,
              padding: .all(16),
              child: Text('Do Filho'),
            ),
          ),
        ],
      ),
    );
  }
}

// A arena entrega ao filho uma constraint LOOSE e mostra, embaixo, o tamanho
// que ele devolveu. E a regra da aula ficando visivel: o size sobe.
class Arena extends StatefulWidget {
  const Arena({super.key, required this.titulo, required this.filho});

  final String titulo;
  final Widget filho;

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

  // O tamanho do filho so existe DEPOIS que o layout rodou. Por isso a leitura
  // acontece no fim do frame, e nao dentro do build.
  void _medir() {
    if (!mounted) return;
    final caixa =
        _chaveDoFilho.currentContext?.findRenderObject() as RenderBox?;
    if (caixa == null || caixa.size == _tamanhoQueSubiu) return;
    setState(() => _tamanhoQueSubiu = caixa.size);
  }

  @override
  Widget build(BuildContext context) {
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
            // * O Center afrouxa: o filho recebe 0..280 x 0..130 e escolhe
            // * dentro disso. Sem ele, a constraint desceria tight.
            child: Center(
              child: KeyedSubtree(key: _chaveDoFilho, child: widget.filho),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'desceu: 0..280 x 0..130   |   SUBIU: ${_formatar(_tamanhoQueSubiu)}',
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

// exemplo_03_cadeia_ate_o_avo_inicio.dart
// Tres niveis aninhados: o neto (Text), o pai (Container) e o avo (Container
// com padding). Nenhum dos tres tem tamanho fixo.
//
// Rode e leia os tres tamanhos medidos. Quem respondeu primeiro foi o mais
// fundo - o texto. Os outros dois so repassaram o que veio de baixo.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaCadeia()));

class TelaCadeia extends StatefulWidget {
  const TelaCadeia({super.key});

  @override
  State<TelaCadeia> createState() => _TelaCadeiaState();
}

class _TelaCadeiaState extends State<TelaCadeia> {
  final _chaveDoNeto = GlobalKey();
  final _chaveDoPai = GlobalKey();
  final _chaveDoAvo = GlobalKey();

  Size? _neto;
  Size? _pai;
  Size? _avo;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _medir());
  }

  // Os tres tamanhos so existem depois que o layout rodou.
  void _medir() {
    if (!mounted) return;
    setState(() {
      _neto = _tamanhoDe(_chaveDoNeto);
      _pai = _tamanhoDe(_chaveDoPai);
      _avo = _tamanhoDe(_chaveDoAvo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('O tamanho sobe ate o avo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Ninguem aqui tem tamanho fixo. Quem define o tamanho de todo '
            'mundo e o texto la no fundo.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),

          // O Align afrouxa a constraint do ListView (que desce tight) e o
          // ConstrainedBox poe um teto frouxo de 320 na cadeia.
          Align(
            alignment: Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: Container(
                key: _chaveDoAvo,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: Container(
                  key: _chaveDoPai,
                  color: Colors.amber,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      'Oi',
                      key: _chaveDoNeto,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 28),
          const Text(
            'O que cada um devolveu para o pai dele:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _LinhaDaCadeia(ordem: '1o', quem: 'Text (neto)', tamanho: _neto),
          _LinhaDaCadeia(ordem: '2o', quem: 'Container (pai)', tamanho: _pai),
          _LinhaDaCadeia(ordem: '3o', quem: 'Container (avo)', tamanho: _avo),
        ],
      ),
    );
  }
}

Size? _tamanhoDe(GlobalKey chave) {
  final caixa = chave.currentContext?.findRenderObject() as RenderBox?;
  return caixa?.hasSize == true ? caixa!.size : null;
}

class _LinhaDaCadeia extends StatelessWidget {
  const _LinhaDaCadeia({
    required this.ordem,
    required this.quem,
    required this.tamanho,
  });

  final String ordem;
  final String quem;
  final Size? tamanho;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 32, child: Text(ordem)),
          SizedBox(width: 170, child: Text(quem)),
          Text(
            _formatar(tamanho),
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
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
  return 'subiu $l x $a';
}

// exemplo_05_constroi_tudo_inicio.dart
// Mil itens dentro de um SingleChildScrollView.
//
// Role a lista. Funciona: não estoura, não dá erro, o scroll é suave.
//
// A pergunta que a tela ainda não responde: para mostrar os ~11 itens que
// cabem na tela (cada um tem 48 px, a janela abaixo do AppBar tem 544),
// quantos o Flutter construiu?

import 'package:flutter/material.dart';

// Troque este número e dê hot reload para sentir a diferença.
const _quantos = 1000;

void main() => runApp(const AppConstroiTudo());

class AppConstroiTudo extends StatelessWidget {
  const AppConstroiTudo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quantos ele constrói?',
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const TelaLista(),
    );
  }
}

class TelaLista extends StatefulWidget {
  const TelaLista({super.key});

  @override
  State<TelaLista> createState() => _TelaListaState();
}

class _TelaListaState extends State<TelaLista> {
  int _builds = 0;
  int _total = 0;
  int _micros = 0;
  final _cronometro = Stopwatch();

  @override
  void initState() {
    super.initState();
    _cronometro.start();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cronometro.stop();
      if (!mounted) return;
      setState(() {
        _total = _builds;
        _micros = _cronometro.elapsedMicroseconds;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quantos filhos ele constrói?')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _Painel(construidos: _total, micros: _micros),
            Divider(height: 1),
            Column(
              children: List.generate(
                _quantos,
                (i) => _ContaBuild(
                  aoConstruir: () => _builds++,
                  child: ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      radius: 14,
                      child: Text('$i', style: const TextStyle(fontSize: 10)),
                    ),
                    title: Text('Item $i'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContaBuild extends StatelessWidget {
  final VoidCallback aoConstruir;
  final Widget child;

  const _ContaBuild({required this.aoConstruir, required this.child});

  @override
  Widget build(BuildContext context) {
    aoConstruir();
    return child;
  }
}

class _Painel extends StatelessWidget {
  final int construidos;
  final int micros;

  const _Painel({required this.construidos, required this.micros});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .all(1.0),
      child: Text(
        'Filhos declarados: $_quantos\n'
        'Filhos Construidos: $construidos (TODOS)\n'
        'Filhos visiveis:  ~14 (Janela de 600px, itens de 64)'
        'Primeiro frame: ${(micros / 1000).toStringAsFixed(1)} ms',
        style: TextStyle(fontFamily: 'monospace', fontSize: 12),
      ),
    );
  }
}

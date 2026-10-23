// exemplo_03_cache_inicio.dart
// Uma lista de 500 itens com um placar em cima.
//
// O placar conta quantas vezes o itemBuilder foi chamado, quais índices estão
// vivos agora e quantos já foram destruídos.
//
// Role a lista devagar e olhe os três números mudarem.

import 'package:flutter/material.dart';

void main() => runApp(const AppCache());

const double kAlturaItem = 80.0;
const int kTotal = 500;

class AppCache extends StatelessWidget {
  const AppCache({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Role e olhe os números',
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple),
      home: const TelaLazy(),
    );
  }
}

// O placar vive fora da árvore para o contador não se perder no rebuild.
class Placar {
  int builds = 0;
  final vivos = <int>{};
  int desmontados = 0;

  final texto = ValueNotifier<String>('');
  bool _agendado = false;

  void avisar() {
    if (_agendado) return;
    _agendado = true;
    // ! O itemBuilder roda durante o LAYOUT. Mexer em ValueNotifier aqui
    // ! dispararia rebuild no meio do layout -> erro. Por isso o post-frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _agendado = false;
      final ord = vivos.toList()..sort();
      final faixa = ord.isEmpty ? '-' : '${ord.first}..${ord.last}';
      texto.value =
          'Chamadas do itemBuilder (acumulado): $builds\n'
          'Itens VIVOS agora: ${vivos.length}   (índices $faixa)\n'
          'Itens DESTRUÍDOS até agora: $desmontados';
    });
  }
}

class TelaLazy extends StatelessWidget {
  const TelaLazy({super.key});

  @override
  Widget build(BuildContext context) {
    final placar = Placar();
    return Scaffold(
      appBar: AppBar(title: const Text('Role e olhe os números')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.deepPurple.shade50,
            child: ValueListenableBuilder<String>(
              valueListenable: placar.texto,
              builder: (context, t, _) => Text(
                t,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: kTotal,
              scrollCacheExtent: .pixels(250),
              itemBuilder: (context, index) {
                placar.builds++;
                placar.avisar();
                return _ItemEspiao(indice: index, placar: placar);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// StatefulWidget de propósito: só assim dá para ver o initState e o dispose —
// o nascimento e a morte do item.
class _ItemEspiao extends StatefulWidget {
  const _ItemEspiao({required this.indice, required this.placar});

  final int indice;
  final Placar placar;

  @override
  State<_ItemEspiao> createState() => _ItemEspiaoState();
}

class _ItemEspiaoState extends State<_ItemEspiao> {
  @override
  void initState() {
    super.initState();
    widget.placar.vivos.add(widget.indice);
    widget.placar.avisar();
  }

  @override
  void dispose() {
    widget.placar.vivos.remove(widget.indice);
    widget.placar.desmontados++;
    widget.placar.avisar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kAlturaItem,
      child: ListTile(
        leading: CircleAvatar(child: Text('${widget.indice}')),
        title: Text('Item ${widget.indice}'),
        subtitle: const Text('vivo — enquanto durar'),
      ),
    );
  }
}

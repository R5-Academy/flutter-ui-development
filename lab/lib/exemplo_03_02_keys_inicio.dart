// exemplo_03_02_keys_inicio.dart
// PASSO 2 DE 3 — a correção óbvia, que resolve pela metade.
//
// A mesma lista do exemplo_03_01_armadilha_lista_sem_key.dart, agora com uma
// ValueKey em cada item.
//
// Faça o mesmo teste:
//   1. toque no "B" para marcar (fica verde);
//   2. aperte "remover o primeiro";
//   3. olhe quem ficou verde.
//
// ! Melhorou: a marca não vai mais para o item errado.
// ! Mas ela some. O estado do "B" se perdeu no caminho.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppKeys());

class AppKeys extends StatelessWidget {
  const AppKeys({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keys na lista',
      theme: ThemeData(colorSchemeSeed: Colors.pink),
      home: const TelaKeys(),
    );
  }
}

class TelaKeys extends StatefulWidget {
  const TelaKeys({super.key});

  @override
  State<TelaKeys> createState() => _TelaKeysState();
}

class _TelaKeysState extends State<TelaKeys> {
  var _itens = ['A', 'B', 'C', 'D', 'E'];

  void _resetar() => setState(() => _itens = ['A', 'B', 'C', 'D', 'E']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keys na lista')),
      body: Column(
        children: [
          const _Instrucoes(),
          _Botoes(
            aoRemover: _itens.isEmpty
                ? null
                : () => setState(() => _itens.removeAt(0)),
            aoResetar: _resetar,
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: _itens.length,
              itemBuilder: (context, index) {
                final nome = _itens[index];
                // A key amarra o Element ao ITEM, e não à posição.
                return _Marcavel(key: ValueKey(nome), nome: nome);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Instrucoes extends StatelessWidget {
  const _Instrucoes();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: Colors.pink.shade50,
      child: const Text(
        'Toque no "B" para marcar (fica verde).\n'
        'Depois aperte "remover o primeiro".\n'
        'Quem fica verde?',
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}

class _Botoes extends StatelessWidget {
  const _Botoes({required this.aoRemover, required this.aoResetar});

  final VoidCallback? aoRemover;
  final VoidCallback aoResetar;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        ElevatedButton(
          onPressed: aoRemover,
          child: const Text('remover o primeiro'),
        ),
        OutlinedButton(onPressed: aoResetar, child: const Text('recomeçar')),
      ],
    );
  }
}

// Item com estado LOCAL (o "marcado"). É esse estado que se perde — ou que
// gruda no item errado.
class _Marcavel extends StatefulWidget {
  const _Marcavel({super.key, required this.nome});

  final String nome;

  @override
  State<_Marcavel> createState() => _MarcavelState();
}

class _MarcavelState extends State<_Marcavel> {
  bool _marcado = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      // ! tileColor (e não um Container colorido em volta): o ListTile pinta o
      // ! próprio fundo no Material mais próximo. Um ColoredBox em volta
      // ! esconderia a cor e o splash — o Flutter avisa isso com um assert.
      child: ListTile(
        tileColor: _marcado ? Colors.green.shade300 : Colors.grey.shade200,
        onTap: () => setState(() => _marcado = !_marcado),
        title: Text(
          widget.nome,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(_marcado ? 'MARCADO' : 'toque para marcar'),
      ),
    );
  }
}

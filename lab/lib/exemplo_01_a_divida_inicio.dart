// exemplo_01_a_divida_inicio.dart
// Uma lista de 500 itens, com altura fixa de 80 pixels cada.
//
// Cada item mostra em que posição ele começa: o item 3 começa no pixel 240, o
// item 10 no pixel 800.
//
// O painel do topo já está montado para mostrar esse número em tempo real — e
// está travado em 0,0. Role a lista: ele não se mexe. O aplicativo sabe
// exatamente onde você está; a gente, não. Falta de onde ler.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppDaDivida());

class AppDaDivida extends StatelessWidget {
  const AppDaDivida({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onde eu estou na lista?',
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const TelaDaDivida(),
    );
  }
}

class TelaDaDivida extends StatefulWidget {
  const TelaDaDivida({super.key});

  @override
  State<TelaDaDivida> createState() => _TelaDaDividaState();
}

class _TelaDaDividaState extends State<TelaDaDivida> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Onde eu estou na lista?')),
      body: Column(
        children: [
          // Zeros fixos: não há nada de onde ler o offset ainda.
          const _Painel(offset: 0, maximo: 0, janela: 0),
          Expanded(
            child: ListView.builder(
              itemExtent: 80,
              itemCount: 500,
              itemBuilder: (context, indice) => ListTile(
                leading: CircleAvatar(child: Text('$indice')),
                title: Text('Item $indice'),
                subtitle: Text('offset deste item: ${indice * 80}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// O cartão do topo: offset grande, barra de progresso e a conta do
// maxScrollExtent. Enquanto `maximo` for 0 ele avisa que não há fonte.
class _Painel extends StatelessWidget {
  const _Painel({
    required this.offset,
    required this.maximo,
    required this.janela,
  });

  final double offset;
  final double maximo;
  final double janela;

  @override
  Widget build(BuildContext context) {
    final progresso = maximo > 0 ? (offset / maximo).clamp(0.0, 1.0) : 0.0;
    final semFonte = maximo == 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        children: [
          const Text('offset', style: TextStyle(fontSize: 12)),
          Text(
            offset.toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.bold,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: progresso),
          const SizedBox(height: 8),
          if (semFonte)
            const Text(
              'sem ScrollController: não há de onde ler o número',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            )
          else ...<Widget>[
            // a conta que o aluno já conhece da aula 02: 500 x 80 = 40000
            Text(
              'maxScrollExtent: ${maximo.toStringAsFixed(1)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            // ! A CONTA FECHA NA TELA, com os números DESTA tela.
            // ! Não decore o resultado: ele muda com o tamanho da janela, e a
            // ! janela é a da LISTA (a tela menos a AppBar, menos este painel).
            Text(
              '40000 (conteúdo) − ${janela.toStringAsFixed(0)} (viewport) '
              '= ${(40000 - janela).toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 12),
            ),
            const Text(
              'maxScrollExtent = conteúdo - viewport (NÃO é a altura total)',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ],
      ),
    );
  }
}

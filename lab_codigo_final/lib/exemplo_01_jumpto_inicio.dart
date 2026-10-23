// exemplo_01_jumpto_inicio.dart
// Uma lista de 500 itens com um ScrollController ligado, e a bancada de medição
// já montada: o placar de builds no topo, o campo "item" e os seis botões de
// comando.
//
// Os seis botões estão APAGADOS de propósito: os métodos que eles chamam ainda
// não existem. Você consegue LER onde está — o placar prova — mas ainda não
// consegue MANDAR ir para lugar nenhum: para chegar no item 400, só arrastando.

import 'package:flutter/material.dart';

// O tipo é double? de propósito: trocar este valor para null tira a dica de
// altura da lista, e é assim que se compara o custo do salto.
// ignore: unnecessary_nullable_for_final_variable_declarations
const double? kItemExtent = 80.0;

void main() => runApp(const AppDoSalto());

class AppDoSalto extends StatelessWidget {
  const AppDoSalto({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'jumpTo x animateTo',
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: const TelaDoSalto(),
    );
  }
}

class TelaDoSalto extends StatefulWidget {
  const TelaDoSalto({super.key});

  @override
  State<TelaDoSalto> createState() => _TelaDoSaltoState();
}

class _TelaDoSaltoState extends State<TelaDoSalto> {
  final controle = ScrollController();
  final campoItem = TextEditingController(text: '400');

  // o contador de builds: quantas vezes o itemBuilder rodou
  int builds = 0;
  var ultimaAcao = 'nada ainda';

  @override
  void initState() {
    super.initState();
    // ! O `max` do placar é lido no build. No primeiro build o ListView ainda
    // ! não existe -> hasClients é false -> max fica 0.0. Um rebuild depois do
    // ! primeiro frame acerta o número, porque aí a position já attachou e o
    // ! layout já mediu. É a mesma armadilha que vai valer para os comandos.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    controle.dispose();
    campoItem.dispose();
    super.dispose();
  }

  void _zerar() => setState(() {
    builds = 0;
    ultimaAcao = 'contador zerado';
  });

  void irPara(double alvo, {required bool animado}) {
    if (!controle.hasClients) {
      return;
    }

    if (animado) {
      controle.animateTo(
        alvo,
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    } else {
      controle.jumpTo(alvo);
      ultimaAcao = 'jumpTo(${alvo.toStringAsFixed(0)})';
    }
  }

  void irParaOFim({required bool animado}) {
    if (!controle.hasClients) return;
    irPara(controle.position.maxScrollExtent, animado: animado);
  }

  void irParaItem({required bool animado}) {
    final indice = int.tryParse(campoItem.text) ?? 0;
    irPara((indice * 80), animado: animado);
  }

  @override
  Widget build(BuildContext context) {
    final max = controle.hasClients ? controle.position.maxScrollExtent : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('jumpTo x animateTo'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(96),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'builds: $builds',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '$ultimaAcao\nmax: ${max.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                    TextButton(onPressed: _zerar, child: const Text('zerar')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              alignment: WrapAlignment.center,
              children: [
                // Os quatro onPressed são null: os comandos entram na aula.
                FilledButton(
                  onPressed: () {
                    irPara(0, animado: false);
                  },
                  child: Text('jump topo'),
                ),
                FilledButton(
                  onPressed: () {
                    irParaOFim(animado: false);
                  },
                  child: Text('jump FIM'),
                ),
                FilledButton.tonal(
                  onPressed: () {
                    irPara(0, animado: true);
                  },
                  child: Text('animate topo'),
                ),
                FilledButton.tonal(
                  onPressed: () {
                    irParaOFim(animado: true);
                  },
                  child: Text('animate FIM'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            // ! Wrap, não Row: em 360 dp os três filhos somam 349 px numa
            // ! faixa de 344 e a Row estourava 5,1 px (a listra amarela e
            // ! preta, ao vivo, na aula seguinte à de overflow).
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SizedBox(
                  width: 90,
                  child: TextField(
                    controller: campoItem,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'item',
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                FilledButton.tonal(
                  onPressed: () {
                    irParaItem(animado: false);
                  },
                  child: Text('jump item'),
                ),
                FilledButton.tonal(
                  onPressed: () {
                    irParaItem(animado: true);
                  },
                  child: Text('animate item'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              controller: controle,
              // a chave da medição: com ou sem itemExtent
              itemExtent: kItemExtent,
              itemCount: 500,
              itemBuilder: (context, indice) {
                builds++;
                return SizedBox(
                  height: kItemExtent == null ? 80 : null,
                  child: ListTile(
                    leading: CircleAvatar(child: Text('$indice')),
                    title: Text('Item $indice'),
                    subtitle: Text('offset: ${indice * 80}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

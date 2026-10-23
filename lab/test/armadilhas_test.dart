import 'package:flutter/material.dart';
// ! ScrollCacheExtent NÃO vem do material.dart — mora em rendering.dart.
import 'package:flutter_test/flutter_test.dart';

import 'package:gridview_lab/exemplo_03_02_armadilha_celula_que_nao_cresce.dart'
    as errado;
import 'package:gridview_lab/exemplo_03_01_aspect_ratio_inicio.dart' as inicio;

// * Bancada das ARMADILHAS: capturando os erros reais, com a mensagem real.

class Registro {
  final construidos = <int>[];
  final vivos = <int>{};
}

class Espiao extends StatefulWidget {
  const Espiao({super.key, required this.indice, required this.registro});

  final int indice;
  final Registro registro;

  @override
  State<Espiao> createState() => _EspiaoState();
}

class _EspiaoState extends State<Espiao> {
  @override
  void initState() {
    super.initState();
    widget.registro.vivos.add(widget.indice);
  }

  @override
  void dispose() {
    widget.registro.vivos.remove(widget.indice);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const ColoredBox(color: Colors.blue);
}

Widget _app(Widget filho) => MaterialApp(home: Scaffold(body: filho));

/// Coleta TODOS os erros de um pump (o layout quebrado repete o erro por frame).
Future<List<String>> _coletarErros(WidgetTester tester, Widget arvore) async {
  final erros = <String>[];
  final anterior = FlutterError.onError;
  FlutterError.onError = (detalhes) => erros.add(detalhes.exceptionAsString());
  await tester.pumpWidget(arvore);
  FlutterError.onError = anterior;
  // * limpa a fila do tester para o teste não falhar por exceção pendente
  while (tester.takeException() != null) {}
  return erros;
}

void main() {
  // ! REGRESSÃO — o exemplo _errado tem que estourar em QUALQUER janela.
  // ! Uma versão anterior usava 2 colunas sem palco: em 800 a célula ficava
  // ! 400x200 e o card (132) cabia folgado — zero erros em 800 e em 1280, ou
  // ! seja, a demo do overflow não acontecia na tela do professor.
  // ! Se este teste falhar, alguém tirou o kPalco ou mexeu no ratio.
  for (final tela in const <Size>[
    Size(411, 867),
    Size(800, 600),
    Size(1280, 800),
  ]) {
    testWidgets('o _errado estoura em ${tela.width.toInt()}px', (tester) async {
      tester.view.physicalSize = tela;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      final erros = await _coletarErros(
        tester,
        const errado.AppDoAspectRatio(),
      );

      // * célula de 200x100 (palco de 400, 2 colunas, ratio 2.0)
      expect(tester.getSize(find.byType(Card).first), const Size(200, 100));
      expect(erros, isNotEmpty);
      expect(
        erros.first,
        contains('A RenderFlex overflowed by 32 pixels on the bottom'),
      );
    });

    testWidgets('o _inicio NÃO estoura em ${tela.width.toInt()}px', (
      tester,
    ) async {
      tester.view.physicalSize = tela;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      final errosInicio = await _coletarErros(
        tester,
        const inicio.AppDoAspectRatio(),
      );
      // * ratio 0.85 sobre 200 de largura -> 235,3 de altura: o card cabe
      expect(errosInicio, isEmpty);
    });
  }

  // ! ARMADILHA 1 — GridView dentro de Column sem Expanded.
  testWidgets('GridView dentro de Column: qual é o erro REAL?', (tester) async {
    final erros = await _coletarErros(
      tester,
      _app(
        Column(
          children: <Widget>[
            const Text('cabeçalho'),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: 10,
              itemBuilder: (context, indice) =>
                  const ColoredBox(color: Colors.blue),
            ),
          ],
        ),
      ),
    );

    debugPrint('=== GridView dentro de Column, sem Expanded ===');
    debugPrint('erros disparados: ${erros.length}');
    debugPrint('primeira linha: ${erros.first.split('\n').first}');
    debugPrint('! É o MESMO erro do ListView. O GridView é um viewport igual.');

    expect(
      erros.first,
      contains('Vertical viewport was given unbounded height'),
    );
  });

  // ! ARMADILHA 2 — o overflow do childAspectRatio. O erro nº 1 do grid.
  testWidgets('childAspectRatio apertado: o RenderFlex overflowed real', (
    tester,
  ) async {
    final erros = await _coletarErros(
      tester,
      _app(
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            // * 4 colunas em 800 -> 200 de largura. ratio 2.0 -> só 100 de ALTURA.
            childAspectRatio: 2.0,
          ),
          itemCount: 8,
          itemBuilder: (context, indice) => Card(
            child: Column(
              children: <Widget>[
                const Icon(Icons.image, size: 48),
                Text('Item $indice'),
                const Text('subtítulo que não cabe'),
                const Icon(Icons.star),
              ],
            ),
          ),
        ),
      ),
    );

    debugPrint('=== childAspectRatio 2.0 com 4 colunas: célula de 200x100 ===');
    debugPrint(
      'conteúdo pedido: ícone 48 + texto + texto + ícone = bem mais que 100',
    );
    debugPrint('erros disparados: ${erros.length} (um por célula estourada)');
    debugPrint('mensagem: ${erros.first.split('\n').first}');
    debugPrint(
      '! A célula NÃO cresce para caber o filho. O delegate crava a altura.',
    );

    expect(erros.first, contains('overflowed'));
  });

  // ! ARMADILHA 2b — o mesmo conteúdo, com a altura certa: sem erro.
  // ! Este caso foi para a aula GridView: Ajuste Fino e Quando Não Usar
  // ! Grade, que é a dona dele. Não recoloque.
  // ! ARMADILHA 3 — shrinkWrap mata o lazy? Só quando a constraint é infinita.
  // ! Este caso foi para a aula GridView: Ajuste Fino e Quando Não Usar
  // ! Grade, que é a dona dele. Não recoloque.
  // ! ARMADILHA 3b — shrinkWrap dentro de constraint INFINITA: aí sim constrói tudo.
  // ! Este caso foi para a aula GridView: Ajuste Fino e Quando Não Usar
  // ! Grade, que é a dona dele. Não recoloque.
  // ! O scrollCacheExtent vale para o GridView também? Medindo.
  // ! Este caso foi para a aula GridView: Ajuste Fino e Quando Não Usar
  // ! Grade, que é a dona dele. Não recoloque.
  // ! GridView.count com children gerados por .map() numa lista grande.
  // ! Este caso foi para a aula GridView: Ajuste Fino e Quando Não Usar
  // ! Grade, que é a dona dele. Não recoloque.
}

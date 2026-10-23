import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gridview_lab/exemplo_01_a_ponte_inicio.dart' as ponte_inicio;

// * Bancada de medição do lazy em grade. Não é material de aula —
// * é o laboratório que produz os NÚMEROS que a aula afirma.
// * Tela padrão do flutter_test: 800x600 (logical pixels).
// !
// ! ATENÇÃO: as MEDIÇÕES 1 a 7 montam o grid direto no Scaffold.body — sem
// ! AppBar e sem painel. O viewport delas é a tela inteira. Os EXEMPLOS da aula
// ! têm AppBar e painel, então os números são MENORES. Quando o cronograma
// ! citar um total, ele tem que citar o do exemplo, não o daqui — foi
// ! exatamente esse deslize que a aula 02 teve que corrigir.
// ! A MEDIÇÃO 8, no fim do arquivo, mede os exemplos DE VERDADE.

/// Registro de quem foi construído e de quem está vivo agora.
class Registro {
  final construidos = <int>[];
  final vivos = <int>{};
  final descartados = <int>[];

  void limpar() {
    construidos.clear();
    vivos.clear();
    descartados.clear();
  }
}

/// Espião: registra o build, a montagem e a desmontagem de cada célula.
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
    widget.registro.descartados.add(widget.indice);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.blue.shade100,
      child: Center(child: Text('${widget.indice}')),
    );
  }
}

Widget _app(Widget filho) => MaterialApp(home: Scaffold(body: filho));

void main() {
  // ! MEDIÇÃO 1 — quantos itemBuilder o GridView.builder chama com 500 itens?
  testWidgets('500 itens, 2 colunas, aspectRatio padrão: quantos builds?', (
    tester,
  ) async {
    final registro = Registro();

    await tester.pumpWidget(
      _app(
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: 500,
          itemBuilder: (context, indice) {
            registro.construidos.add(indice);
            return Espiao(indice: indice, registro: registro);
          },
        ),
      ),
    );

    debugPrint(
      '=== 2 colunas, childAspectRatio padrão (1.0), tela 800x600 ===',
    );
    debugPrint(
      'Célula: 800/2 = 400 de largura; aspectRatio 1.0 -> 400 de altura.',
    );
    debugPrint('Builds chamados: ${registro.construidos.length}');
    debugPrint('Índices construídos: ${registro.construidos}');
    debugPrint('Elements vivos agora: ${registro.vivos.length}');

    // * O número exato é cravado pelo teste — a aula projeta este print.
    expect(registro.construidos.length, greaterThan(0));
  });

  // ! MEDIÇÃO 2 — o mesmo grid, mas com células BAIXAS (aspectRatio alto).
  testWidgets('500 itens, 2 colunas, células de 80 de altura: quantos builds?', (
    tester,
  ) async {
    final registro = Registro();

    await tester.pumpWidget(
      _app(
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 80, // * altura cravada: comparável à lista de 80px
          ),
          itemCount: 500,
          itemBuilder: (context, indice) {
            registro.construidos.add(indice);
            return Espiao(indice: indice, registro: registro);
          },
        ),
      ),
    );

    debugPrint(
      '=== 2 colunas, mainAxisExtent 80 (mesma altura da aula de ListView) ===',
    );
    debugPrint('Builds chamados: ${registro.construidos.length}');
    debugPrint('Elements vivos: ${registro.vivos.length}');
    expect(registro.construidos.length, greaterThan(0));
  });

  // ! MEDIÇÃO 3 — o ListView equivalente (o número da aula passada: 11).
  testWidgets('ListView.builder 500 itens de 80px: o número de referência', (
    tester,
  ) async {
    final registro = Registro();

    await tester.pumpWidget(
      _app(
        ListView.builder(
          itemCount: 500,
          itemBuilder: (context, indice) {
            registro.construidos.add(indice);
            return SizedBox(
              height: 80,
              child: Espiao(indice: indice, registro: registro),
            );
          },
        ),
      ),
    );

    debugPrint(
      '=== ListView.builder, itens de 80px (referência da aula 02) ===',
    );
    debugPrint('Builds chamados: ${registro.construidos.length}');
    expect(registro.construidos.length, greaterThan(0));
  });

  // ! MEDIÇÃO 4 — GridView(children:) é lazy nos Elements? (achado do ListView)
  // ! Este caso foi para a aula GridView: Ajuste Fino e Quando Não Usar
  // ! Grade, que é a dona dele. Não recoloque.
  // ! MEDIÇÃO 5 — GridView.count e .extent também são lazy nos Elements?
  // ! Este caso foi para a aula GridView: Ajuste Fino e Quando Não Usar
  // ! Grade, que é a dona dele. Não recoloque.
  // ! Este caso foi para a aula GridView: Ajuste Fino e Quando Não Usar
  // ! Grade, que é a dona dele. Não recoloque.
  // ! MEDIÇÃO 6 — o item que sai da tela é destruído?
  testWidgets('rolar destrói o que saiu da tela?', (tester) async {
    final registro = Registro();

    await tester.pumpWidget(
      _app(
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 100,
          ),
          itemCount: 500,
          itemBuilder: (context, indice) {
            registro.construidos.add(indice);
            return Espiao(indice: indice, registro: registro);
          },
        ),
      ),
    );

    debugPrint('--- antes de rolar ---');
    debugPrint(
      'vivos: ${registro.vivos.length} -> ${registro.vivos.toList()..sort()}',
    );

    await tester.drag(find.byType(GridView), const Offset(0, -1000));
    await tester.pump();

    debugPrint('--- após rolar 1000px para cima ---');
    debugPrint(
      'vivos: ${registro.vivos.length} -> ${registro.vivos.toList()..sort()}',
    );
    debugPrint('descartados (dispose chamado): ${registro.descartados.length}');
    debugPrint('total de builds acumulados: ${registro.construidos.length}');

    expect(registro.descartados, isNotEmpty);
  });

  // ! MEDIÇÃO 7 — o SALTO: pular para o item 400 custa quantos builds?
  testWidgets('saltar para o item 400: quantos builds no grid?', (
    tester,
  ) async {
    final registro = Registro();

    await tester.pumpWidget(
      _app(
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 100,
          ),
          itemCount: 500,
          itemBuilder: (context, indice) {
            registro.construidos.add(indice);
            return Espiao(indice: indice, registro: registro);
          },
        ),
      ),
    );

    final buildsIniciais = registro.construidos.length;
    registro.construidos.clear();

    // * item 400 -> linha 200 -> offset 200 * 100 = 20000
    // * jumpTo é assunto da aula 04; aqui usamos o gesto de rolagem do próprio
    // * viewport via Scrollable.ensureVisible? Não: usamos drag grande.
    // * Para medir o SALTO sem ScrollController, mexemos na posição direto.
    final estado = tester.state<ScrollableState>(find.byType(Scrollable));
    estado.position.jumpTo(20000);
    await tester.pump();

    debugPrint(
      '=== SALTO para o offset do item 400 (grade 2 colunas, 100px) ===',
    );
    debugPrint('builds no primeiro frame: $buildsIniciais');
    debugPrint('builds gastos no salto: ${registro.construidos.length}');
    debugPrint('índices construídos no salto: ${registro.construidos..sort()}');

    expect(registro.construidos.length, greaterThan(0));
  });

  // ! MEDIÇÃO 8 — o exemplo `_inicio` (com AppBar e painel) + a grade
  // ! montada na bancada. Duas afirmações, nesta ordem:
  // !   1. a lista do `_inicio` obedece à conta clássica do cache;
  // !   2. com mainAxisExtent 80 (a altura do item da lista), a grade
  // !      constrói EXATAMENTE o dobro — o "2x" valia, sob uma premissa
  // !      que o delegate não garante.
  for (final tela in const <Size>[
    Size(360, 800),
    Size(411, 867),
    Size(800, 600),
    Size(1280, 800),
  ]) {
    testWidgets(
      'exemplo 01 em ${tela.width.toInt()}px: lista e o dobro com extent 80',
      (tester) async {
        tester.view.physicalSize = tela;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(const ponte_inicio.AppDaPonte());
        final naLista = find
            .byType(ponte_inicio.Celula, skipOffstage: false)
            .evaluate()
            .length;
        final alturaDaLista = tester.getSize(find.byType(ListView)).height;

        debugPrint(
          '=== exemplo 01 em ${tela.width.toInt()}x${tela.height.toInt()} ===',
        );
        debugPrint('lista: $naLista itens (viewport de ${alturaDaLista}px)');

        expect(
          naLista,
          ((alturaDaLista + ponte_inicio.kCacheExtentPadrao) /
                  ponte_inicio.kAlturaItem)
              .ceil(),
        );

        // * o "dobro" aparece quando a célula tem a altura do item da lista
        final registro = Registro();
        await tester.pumpWidget(
          _app(
            Column(
              children: <Widget>[
                SizedBox(height: tela.height - alturaDaLista),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: ponte_inicio.kAlturaItem,
                        ),
                    itemCount: 500,
                    itemBuilder: (context, indice) {
                      registro.construidos.add(indice);
                      return Espiao(indice: indice, registro: registro);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
        debugPrint(
          'grade com mainAxisExtent 80: ${registro.construidos.length} '
          '(= 2 x $naLista)',
        );
        expect(registro.construidos.length, naLista * 2);
      },
    );
  }
}

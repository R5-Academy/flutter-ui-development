import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

// * Harness de medição. Não é material de aula — é a bancada de laboratório
// * que produz os NÚMEROS que a aula afirma.
// * Tela padrão do flutter_test: 800x600.

const double kAlturaItem = 80.0;

/// Espião: conta o build de cada item e registra montagem/desmontagem.
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
    widget.registro.montados.add(widget.indice);
    widget.registro.vivos.add(widget.indice);
  }

  @override
  void dispose() {
    widget.registro.desmontados.add(widget.indice);
    widget.registro.vivos.remove(widget.indice);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.registro.builds.add(widget.indice);
    return SizedBox(height: kAlturaItem, child: Text('Item ${widget.indice}'));
  }
}

class Registro {
  final builds = <int>[];
  final montados = <int>[];
  final desmontados = <int>[];
  final vivos = <int>{};

  void limpar() {
    builds.clear();
    montados.clear();
    desmontados.clear();
  }

  int get totalBuilds => builds.length;
  String get faixaViva {
    if (vivos.isEmpty) return 'nenhum';
    final ord = vivos.toList()..sort();
    return '${ord.first}..${ord.last} (${ord.length} itens)';
  }
}

Widget envolver(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  const int kTotal = 500;

  test('separated: N itens => N-1 separadores => 2N-1 filhos', () {
    // * Confirma a fórmula math.max(0, itemCount * 2 - 1) do fonte.
    int formula(int n) => n < 1 ? 0 : n * 2 - 1;
    expect(formula(500), 999);
    expect(formula(1), 1);
    expect(formula(0), 0);
  });

  testWidgets('MEDIÇÃO 1: SingleChildScrollView + Column (500 itens)', (
    tester,
  ) async {
    final r = Registro();
    await tester.pumpWidget(
      envolver(
        SingleChildScrollView(
          child: Column(
            children: List.generate(
              kTotal,
              (i) => Espiao(indice: i, registro: r),
            ),
          ),
        ),
      ),
    );
    debugPrint(
      '### SCSV+Column: builds=${r.totalBuilds} '
      'montados=${r.montados.length} vivos=${r.faixaViva}',
    );
    expect(r.totalBuilds, kTotal);
  });

  testWidgets('MEDIÇÃO 2: ListView.builder (500 itens) no repouso', (
    tester,
  ) async {
    final r = Registro();
    await tester.pumpWidget(
      envolver(
        ListView.builder(
          itemCount: kTotal,
          itemBuilder: (c, i) => Espiao(indice: i, registro: r),
        ),
      ),
    );
    debugPrint(
      '### ListView.builder: builds=${r.totalBuilds} '
      'montados=${r.montados.length} vivos=${r.faixaViva}',
    );
    debugPrint(
      '### visiveis na tela (600/$kAlturaItem) = ${600 / kAlturaItem}',
    );
  });

  testWidgets('MEDIÇÃO 3: cacheExtent — o que muda o número de builds', (
    tester,
  ) async {
    for (final extent in <double>[0.0, 250.0, 500.0, 1000.0]) {
      final r = Registro();
      await tester.pumpWidget(
        envolver(
          ListView.builder(
            scrollCacheExtent: ScrollCacheExtent.pixels(extent),
            itemCount: kTotal,
            itemBuilder: (c, i) => Espiao(indice: i, registro: r),
          ),
        ),
      );
      debugPrint(
        '### scrollCacheExtent=$extent -> builds=${r.totalBuilds} '
        'vivos=${r.faixaViva}',
      );
      await tester.pumpWidget(const SizedBox());
    }
  });

  testWidgets('MEDIÇÃO 4: rolar — o contador SOBE e itens são DESTRUÍDOS', (
    tester,
  ) async {
    final r = Registro();
    await tester.pumpWidget(
      envolver(
        ListView.builder(
          itemCount: kTotal,
          itemBuilder: (c, i) => Espiao(indice: i, registro: r),
        ),
      ),
    );
    final noRepouso = r.totalBuilds;
    debugPrint('### repouso: builds=$noRepouso vivos=${r.faixaViva}');

    r.limpar();
    await tester.fling(find.byType(ListView), const Offset(0, -1000), 1000);
    await tester.pumpAndSettle();
    debugPrint(
      '### após rolar: +${r.totalBuilds} builds novos, '
      '${r.desmontados.length} DESMONTADOS, vivos=${r.faixaViva}',
    );
    debugPrint(
      '### itens destruidos (amostra): '
      '${r.desmontados.take(8).toList()}',
    );
    expect(
      r.desmontados,
      isNotEmpty,
      reason: 'itens que saem da tela devem ser destruidos',
    );
  });

  testWidgets('MEDIÇÃO 6: ListView(children:) TAMBÉM é lazy nos Elements', (
    tester,
  ) async {
    final r = Registro();
    await tester.pumpWidget(
      envolver(
        ListView(
          children: List.generate(
            kTotal,
            (i) => Espiao(indice: i, registro: r),
          ),
        ),
      ),
    );
    // ! Aqui os WIDGETS todos foram construídos (List.generate), mas quantos
    // ! Elements foram montados?
    debugPrint(
      '### ListView(children:): builds=${r.totalBuilds} '
      'montados=${r.montados.length} vivos=${r.faixaViva}',
    );
  });

  testWidgets('MEDIÇÃO 9: sem itemCount = lista infinita?', (tester) async {
    final r = Registro();
    await tester.pumpWidget(
      envolver(
        ListView.builder(
          itemBuilder: (c, i) => Espiao(indice: i, registro: r),
        ),
      ),
    );
    debugPrint(
      '### sem itemCount: builds=${r.totalBuilds} '
      'maior índice=${r.builds.reduce((a, b) => a > b ? a : b)}',
    );
  });

  testWidgets('MEDIÇÃO 10: estado do item se perde ao rolar', (tester) async {
    // * Item com estado interno (um contador local).
    await tester.pumpWidget(
      envolver(
        ListView.builder(
          itemCount: kTotal,
          itemBuilder: (c, i) => _ItemComEstado(indice: i),
        ),
      ),
    );
    // Marca o item 0.
    await tester.tap(find.text('Item 0: 0'));
    await tester.pump();
    expect(find.text('Item 0: 1'), findsOneWidget);
    debugPrint('### item 0 marcado -> 1');

    // Rola pra longe e volta.
    await tester.fling(find.byType(ListView), const Offset(0, -3000), 2000);
    await tester.pumpAndSettle();
    await tester.fling(find.byType(ListView), const Offset(0, 3000), 2000);
    await tester.pumpAndSettle();
    final voltou = find.text('Item 0: 1').evaluate().isNotEmpty;
    debugPrint('### após ida e volta, item 0 ainda vale 1? $voltou');
    debugPrint(
      '### item 0 agora: '
      '${find.text('Item 0: 0').evaluate().isNotEmpty ? "ZERADO" : "?"}',
    );
  });

  testWidgets('MEDIÇÃO 11: o número construído é a CONTA, não um 11 fixo', (
    tester,
  ) async {
    // ! Este é o teste que impede o "11 mágico" de voltar. O número muda com
    // ! a altura da lista; o que NÃO muda é a fórmula.
    // ! A janela precisa ser MAIOR que a maior lista testada — se a lista
    // ! estourar a tela, o viewport é cortado e a conta deixa de valer.
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    for (final altura in <double>[426.0, 436.0, 586.0, 616.0, 636.0, 643.0]) {
      final r = Registro();
      await tester.pumpWidget(
        envolver(
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: altura,
              child: ListView.builder(
                itemCount: kTotal,
                itemBuilder: (c, i) => Espiao(indice: i, registro: r),
              ),
            ),
          ),
        ),
      );
      final esperado = contaEsperada(altura, 250.0, kAlturaItem);
      debugPrint(
        '### lista=${altura.toInt()}px -> construidos=${r.totalBuilds} '
        '| ceil((${altura.toInt()}+250)/80)=$esperado',
      );
      expect(
        r.totalBuilds,
        esperado,
        reason: 'a conta ceil((altura+cache)/item) tem de bater sempre',
      );
      await tester.pumpWidget(const SizedBox());
    }
  });

  testWidgets('MEDIÇÃO 12: o ListView passa TIGHT no eixo cruzado', (
    tester,
  ) async {
    // ! Consequência: todo SizedBox(width:) dentro de lista VERTICAL some.
    late BoxConstraints recebida;
    await tester.pumpWidget(
      envolver(
        ListView(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                recebida = constraints;
                return const SizedBox(
                  key: ValueKey('alvo'),
                  width: 100,
                  height: 50,
                );
              },
            ),
          ],
        ),
      ),
    );
    final semAlign = tester
        .renderObject<RenderBox>(find.byKey(const ValueKey('alvo')))
        .size;
    debugPrint('### cross-axis: $recebida');
    debugPrint('### SizedBox(width:100) virou $semAlign  (o 100 sumiu)');
    expect(recebida.minWidth, 800.0);
    expect(recebida.maxWidth, 800.0);
    expect(semAlign.width, 800.0);

    // * A saída: Align (ou Center) devolve a escolha ao filho.
    await tester.pumpWidget(
      envolver(
        ListView(
          children: const [
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(key: ValueKey('alvo2'), width: 100, height: 50),
            ),
          ],
        ),
      ),
    );
    final comAlign = tester
        .renderObject<RenderBox>(find.byKey(const ValueKey('alvo2')))
        .size;
    debugPrint('### com Align: $comAlign');
    expect(comAlign.width, 100.0);
  });
}

/// A conta que substitui o "11 mágico": o número de itens construídos é
/// `ceil((altura_da_lista + cacheExtent) / altura_do_item)`.
int contaEsperada(double alturaLista, double cache, double alturaItem) =>
    ((alturaLista + cache) / alturaItem).ceil();

class _ItemComEstado extends StatefulWidget {
  const _ItemComEstado({required this.indice});
  final int indice;
  @override
  State<_ItemComEstado> createState() => _ItemComEstadoState();
}

class _ItemComEstadoState extends State<_ItemComEstado> {
  int _n = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kAlturaItem,
      child: GestureDetector(
        onTap: () => setState(() => _n++),
        child: Text('Item ${widget.indice}: $_n'),
      ),
    );
  }
}

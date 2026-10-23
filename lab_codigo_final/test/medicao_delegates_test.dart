import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

// * Bancada de medição dos DOIS delegates: a conta do maxCrossAxisExtent
// * e o efeito colateral do childAspectRatio sobre a ALTURA da célula.

/// Roda o getLayout do delegate direto, sem árvore de widgets.
/// É a matemática pura do delegate — a mesma que o SliverGrid usa.
SliverGridLayout _layout(SliverGridDelegate delegate, double larguraTela) {
  return delegate.getLayout(
    SliverConstraints(
      axisDirection: AxisDirection.down,
      growthDirection: GrowthDirection.forward,
      userScrollDirection: ScrollDirection.idle,
      scrollOffset: 0,
      precedingScrollExtent: 0,
      overlap: 0,
      remainingPaintExtent: 600,
      crossAxisExtent: larguraTela,
      crossAxisDirection: AxisDirection.right,
      viewportMainAxisExtent: 600,
      remainingCacheExtent: 850,
      cacheOrigin: 0,
    ),
  );
}

/// Mede a célula real medindo o RenderBox do primeiro filho na árvore.
Future<Size> _tamanhoDaPrimeiraCelula(
  WidgetTester tester,
  SliverGridDelegate delegate,
) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: GridView.builder(
          gridDelegate: delegate,
          itemCount: 50,
          itemBuilder: (context, indice) =>
              ColoredBox(key: ValueKey(indice), color: Colors.blue),
        ),
      ),
    ),
  );
  return tester.getSize(find.byKey(const ValueKey(0)));
}

void main() {
  // ! A CONTA do maxCrossAxisExtent: crossAxisCount = ceil(largura / (max + crossAxisSpacing))
  test('maxCrossAxisExtent 200: quantas colunas em 800? E em 500?', () {
    const delegate = SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
    );

    final em800 = _layout(delegate, 800);
    final em500 = _layout(delegate, 500);
    final em1000 = _layout(delegate, 1000);
    final em320 = _layout(delegate, 320);

    debugPrint(
      '=== maxCrossAxisExtent: 200 — a conta é ceil(largura / 200) ===',
    );
    for (final (largura, layout) in <(double, SliverGridLayout)>[
      (320, em320),
      (500, em500),
      (800, em800),
      (1000, em1000),
    ]) {
      final regular = layout as SliverGridRegularTileLayout;
      debugPrint(
        'tela ${largura.toInt()}: ceil($largura/200) = '
        '${(largura / 200).ceil()} colunas, '
        'cada célula com ${regular.childCrossAxisExtent.toStringAsFixed(2)} de largura',
      );
    }

    // * 800 / 200 = 4.0 -> ceil = 4 colunas -> células de exatamente 200
    expect((em800 as SliverGridRegularTileLayout).childCrossAxisExtent, 200.0);
    // * 500 / 200 = 2.5 -> ceil = 3 colunas -> células de 166.67 (MENORES que 200!)
    expect(
      (em500 as SliverGridRegularTileLayout).childCrossAxisExtent,
      closeTo(166.67, 0.01),
    );
  });

  // ! O crossAxisSpacing entra no DENOMINADOR da conta — detalhe que quase ninguém sabe.
  // ! Este caso foi para a aula GridView: Ajuste Fino e Quando Não Usar
  // ! Grade, que é a dona dele. Não recoloque.
  // ! childAspectRatio: mudar crossAxisCount muda a ALTURA. O efeito colateral.
  testWidgets('crossAxisCount muda a ALTURA da célula (aspectRatio 1.0)', (
    tester,
  ) async {
    final duas = await _tamanhoDaPrimeiraCelula(
      tester,
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
    final tres = await _tamanhoDaPrimeiraCelula(
      tester,
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    );
    final quatro = await _tamanhoDaPrimeiraCelula(
      tester,
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
    );

    debugPrint('=== tela de 800, childAspectRatio 1.0 (padrão) ===');
    debugPrint('2 colunas -> célula ${duas.width} x ${duas.height}');
    debugPrint(
      '3 colunas -> célula ${tres.width.toStringAsFixed(2)} x ${tres.height.toStringAsFixed(2)}',
    );
    debugPrint('4 colunas -> célula ${quatro.width} x ${quatro.height}');
    debugPrint(
      '! Repare: eu só mexi no número de COLUNAS e a ALTURA mudou junto.',
    );

    expect(duas, const Size(400, 400));
    expect(quatro, const Size(200, 200));
  });

  // ! childAspectRatio é largura/altura. Confirmando a direção da divisão.
  testWidgets('childAspectRatio é largura/altura — confirmando a direção', (
    tester,
  ) async {
    // * 2 colunas em 800 -> 400 de largura. ratio 2.0 -> altura = 400/2 = 200.
    final ratio2 = await _tamanhoDaPrimeiraCelula(
      tester,
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.0,
      ),
    );
    // * ratio 0.5 -> altura = 400/0.5 = 800 (célula bem alta)
    final ratioMeio = await _tamanhoDaPrimeiraCelula(
      tester,
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.5,
      ),
    );

    debugPrint('=== childAspectRatio = largura / altura ===');
    debugPrint(
      'ratio 2.0 -> ${ratio2.width} x ${ratio2.height} (largura é o DOBRO da altura)',
    );
    debugPrint(
      'ratio 0.5 -> ${ratioMeio.width} x ${ratioMeio.height} (altura é o DOBRO da largura)',
    );
    debugPrint('fórmula do fonte: altura = larguraDaCelula / childAspectRatio');

    expect(ratio2, const Size(400, 200));
    expect(ratioMeio, const Size(400, 800));
  });

  // ! mainAxisExtent ANULA o childAspectRatio. Tem assert? MEDINDO.
  // ! Este caso foi para a aula GridView: Ajuste Fino e Quando Não Usar
  // ! Grade, que é a dona dele. Não recoloque.
  // ! A conta completa com spacing: usableCrossAxisExtent
  // ! Este caso foi para a aula GridView: Ajuste Fino e Quando Não Usar
  // ! Grade, que é a dona dele. Não recoloque.
}

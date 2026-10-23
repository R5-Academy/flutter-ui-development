import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gridview_lab/exemplo_01_a_ponte_inicio.dart' as e01i;
import 'package:gridview_lab/exemplo_02_dois_delegates_inicio.dart' as e02i;
import 'package:gridview_lab/exemplo_03_01_aspect_ratio_inicio.dart' as e03i;

// * Smoke: cada exemplo `_inicio` sobe.
// * O 03_aspect_ratio_errado é a exceção: ele EXISTE para estourar, e está
// * coberto no armadilhas_test.dart.

void main() {
  testWidgets('01 inicio: é ListView, não grade', (tester) async {
    await tester.pumpWidget(const e01i.AppDaPonte());
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(GridView), findsNothing);
  });

  testWidgets('02 inicio: a bancada pronta, só faltando a grade do .extent', (
    tester,
  ) async {
    await tester.pumpWidget(const e02i.AppDosDelegates());
    await tester.pumpAndSettle();
    expect(find.textContaining('FixedCrossAxisCount'), findsOneWidget);
    expect(find.textContaining('MaxCrossAxisExtent'), findsNothing);
    // ! A BANCADA VEM PRONTA — é o recorte do bloco 2. O slider e o cabeçalho
    // ! com a conta já estão no _inicio; ao vivo só se digita o painel do
    // ! MaxCrossAxisExtent. Se alguém devolver a bancada para a digitação,
    // ! estes expects quebram.
    expect(find.byType(Slider), findsOneWidget);
    expect(find.textContaining('ceil('), findsOneWidget);
    // A grade da esquerda existe; a da direita, não — o Expanded está vazio.
    expect(find.byType(GridView), findsOneWidget);
  });

  testWidgets('03 inicio: ainda usa childAspectRatio', (tester) async {
    await tester.pumpWidget(const e03i.AppDoAspectRatio());
    await tester.pumpAndSettle();
    final grade = tester.widget<GridView>(find.byType(GridView));
    final delegate =
        grade.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
    expect(delegate.mainAxisExtent, isNull);
    expect(delegate.childAspectRatio, 0.85);
  });
}

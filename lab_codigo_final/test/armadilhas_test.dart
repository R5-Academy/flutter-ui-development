import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ARMADILHA: SCSV dentro de SCSV no MESMO eixo', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(height: 300, color: Colors.blue),
                // ! SCSV vertical dentro de SCSV vertical, SEM altura definida.
                SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      20,
                      (i) => Container(height: 50, color: Colors.green),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    final ex = tester.takeException();
    debugPrint('>>> Exceção? ${ex ?? "NENHUMA"}');
    if (ex == null) {
      final internos = find.byType(SingleChildScrollView);
      debugPrint(
        '>>> SCSVs encontrados: ${tester.widgetList(internos).length}',
      );
      final alturas = tester
          .widgetList<SingleChildScrollView>(internos)
          .map((w) => tester.getSize(find.byWidget(w)).height)
          .toList();
      debugPrint('>>> Alturas dos SCSVs (externo, interno): $alturas');
      debugPrint(
        '>>> O interno virou 1000px (shrink-wrap total): NÃO rola sozinho.',
      );
    }
  });

  testWidgets('ARMADILHA: SCSV interno COM altura definida — funciona', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(height: 300, color: Colors.blue),
                SizedBox(
                  height: 200, // * agora o interno tem uma janela de verdade
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        20,
                        (i) => Container(height: 50, color: Colors.green),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
    debugPrint(
      '>>> Com SizedBox(height: 200) em volta: sem erro, e o interno rola.',
    );
  });

  testWidgets('TECLADO: viewInsets e o SCSV', (tester) async {
    Widget app() => MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(6, (i) => const SizedBox(height: 80)),
              const TextField(key: Key('campo')),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );

    await tester.pumpWidget(app());
    debugPrint(
      '>>> SEM teclado — viewInsets.bottom: ${tester.view.viewInsets.bottom}',
    );

    // Simula o teclado. O valor aqui é em pixels FÍSICOS: com
    // devicePixelRatio 3.0, 300 físicos = 100 lógicos no MediaQuery.
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(app());
    await tester.pump();
    expect(tester.takeException(), isNull);

    final ctx = tester.element(find.byType(Scaffold));
    debugPrint(
      '>>> COM teclado — MediaQuery.viewInsets.bottom: '
      '${MediaQuery.of(ctx).viewInsets.bottom}',
    );
    debugPrint(
      '>>> Altura do SCSV (a janela encolheu): '
      '${tester.getSize(find.byType(SingleChildScrollView)).height}',
    );
    debugPrint(
      '>>> Sem overflow porque o SCSV rola. Um Column puro estouraria aqui.',
    );
  });
}

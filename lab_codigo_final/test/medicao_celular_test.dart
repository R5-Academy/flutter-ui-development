import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// * Os números da aula em TELA DE CELULAR (e não na tela 800x600 do test).
// * O professor projeta o emulador: estes são os números que ele vai ver.
// * Pixel-ish: 411.4 x 866.7 logical pixels.

const kTelaCelular = Size(411.4, 866.7);

class Registro {
  final construidos = <int>[];
}

Future<int> _contarBuilds(
  WidgetTester tester,
  SliverGridDelegate delegate,
) async {
  final registro = Registro();
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: GridView.builder(
          gridDelegate: delegate,
          itemCount: 500,
          itemBuilder: (context, indice) {
            registro.construidos.add(indice);
            return const ColoredBox(color: Colors.blue);
          },
        ),
      ),
    ),
  );
  return registro.construidos.length;
}

void main() {
  setUp(() {
    // * força a tela do teste a ter tamanho de celular
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('os números da aula numa tela de celular (411 x 867)', (
    tester,
  ) async {
    tester.view.physicalSize = kTelaCelular;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    final duasColunas = await _contarBuilds(
      tester,
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
    final tresColunas = await _contarBuilds(
      tester,
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    );
    final extent150 = await _contarBuilds(
      tester,
      const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 150),
    );

    // * a lista de referência, na mesma tela
    final registroLista = Registro();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView.builder(
            itemCount: 500,
            itemBuilder: (context, indice) {
              registroLista.construidos.add(indice);
              return const SizedBox(
                height: 80,
                child: ColoredBox(color: Colors.blue),
              );
            },
          ),
        ),
      ),
    );

    debugPrint('=== TELA DE CELULAR: 411 x 867, 500 itens ===');
    debugPrint(
      'ListView.builder, itens de 80px: '
      '${registroLista.construidos.length} builds',
    );
    debugPrint('GridView 2 colunas (célula 205x205): $duasColunas builds');
    debugPrint('GridView 3 colunas (célula 137x137): $tresColunas builds');
    debugPrint('GridView .extent(150) -> 3 colunas: $extent150 builds');
    debugPrint(
      '! Conta do grid de 2 colunas: (867 viewport + 250 cache) / 205 '
      'por linha = 5.4 -> 6 linhas x 2 = 12',
    );
    debugPrint(
      '! O número NÃO é "o dobro da lista". É (viewport+cache) / ALTURA '
      'da célula, vezes as colunas.',
    );

    expect(duasColunas, greaterThan(0));
    expect(tresColunas, greaterThan(duasColunas));
  });
}

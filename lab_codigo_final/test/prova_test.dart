import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('PROVA 1: a constraint que desce para o filho', (tester) async {
    late BoxConstraints capturadas;
    await tester.pumpWidget(
      MaterialApp(
        home: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, c) {
              capturadas = c;
              return const SizedBox(height: 100);
            },
          ),
        ),
      ),
    );
    debugPrint('>>> VERTICAL  : $capturadas');
    debugPrint('>>> maxHeight isInfinite? ${capturadas.maxHeight.isInfinite}');
    debugPrint('>>> hasBoundedHeight? ${capturadas.hasBoundedHeight}');

    late BoxConstraints capturadasH;
    await tester.pumpWidget(
      MaterialApp(
        home: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: LayoutBuilder(
            builder: (context, c) {
              capturadasH = c;
              return const SizedBox(width: 100);
            },
          ),
        ),
      ),
    );
    debugPrint('>>> HORIZONTAL: $capturadasH');
    debugPrint('>>> maxWidth isInfinite? ${capturadasH.maxWidth.isInfinite}');
  });

  testWidgets('PROVA 2: o erro do RenderFlex overflow (SEM scroll)', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: List.generate(
              20,
              (i) => Container(height: 100, color: Colors.blue),
            ),
          ),
        ),
      ),
    );
    final ex = tester.takeException();
    debugPrint('>>> TIPO: ${ex.runtimeType}');
    debugPrint('>>> ERRO OVERFLOW:\n$ex');
  });

  testWidgets('PROVA 3: o erro do Expanded dentro do SingleChildScrollView', (
    tester,
  ) async {
    // ! Um erro de layout cascateia em 13. Se você usar takeException() aqui,
    // ! o que volta é o resumo "Multiple exceptions (13) were detected" — que
    // ! NÃO é a mensagem da aula. Capture na fonte para ver a PRIMEIRA.
    final primeiras = await _primeiroErro(
      tester,
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Text('topo'),
                Expanded(child: ColoredBox(color: Colors.red)),
                Text('base'),
              ],
            ),
          ),
        ),
      ),
    );
    debugPrint('>>> ERRO EXPANDED (as 4 primeiras linhas):');
    for (final linha in primeiras.take(4)) {
      debugPrint('>>> $linha');
    }
    expect(
      primeiras.first,
      'RenderFlex children have non-zero flex but incoming height '
      'constraints are unbounded.',
    );
  });

  testWidgets('PROVA 3b: o Spacer dá exatamente o MESMO erro', (tester) async {
    final primeiras = await _primeiroErro(
      tester,
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [Text('topo'), Spacer(), Text('base')]),
          ),
        ),
      ),
    );
    debugPrint('>>> ERRO SPACER (primeira linha): ${primeiras.first}');
    // * Spacer é um Expanded com SizedBox.shrink dentro — mesma causa, mesmo erro.
    expect(
      primeiras.first,
      'RenderFlex children have non-zero flex but incoming height '
      'constraints are unbounded.',
    );
  });

  testWidgets('PROVA 4: ele constrói TUDO de uma vez (contador)', (
    tester,
  ) async {
    final construidos = <int>[];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: List.generate(1000, (i) {
                return _Spy(
                  indice: i,
                  onBuild: construidos.add,
                  child: const SizedBox(height: 100),
                );
              }),
            ),
          ),
        ),
      ),
    );
    debugPrint('>>> Filhos declarados : 1000');
    debugPrint('>>> Filhos CONSTRUÍDOS: ${construidos.length}');
    debugPrint(
      '>>> Altura da tela    : ${tester.view.physicalSize.height / tester.view.devicePixelRatio}',
    );
    debugPrint(
      '>>> Cabem na tela     : ~${(600 / 100).round()} itens de 100px',
    );
    debugPrint('>>> Último índice construído: ${construidos.last}');
    debugPrint(
      '>>> Altura total do Column: ${tester.getSize(find.byType(Column)).height}',
    );
  });

  testWidgets('PROVA 4b: comparativo — ListView.builder é lazy', (
    tester,
  ) async {
    final construidos = <int>[];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView.builder(
            itemCount: 1000,
            itemBuilder: (context, i) {
              construidos.add(i);
              return const SizedBox(height: 100);
            },
          ),
        ),
      ),
    );
    debugPrint('>>> [ListView.builder] Filhos declarados : 1000');
    debugPrint(
      '>>> [ListView.builder] Filhos CONSTRUÍDOS: ${construidos.length}',
    );
    debugPrint('>>> [ListView.builder] índices: ${construidos.toList()}');
  });

  testWidgets('PROVA 5: debugDumpRenderTree com a constraint infinita', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(height: 400, color: Colors.blue),
                Container(height: 400, color: Colors.green),
              ],
            ),
          ),
        ),
      ),
    );
    debugPrint('>>>>>>>>>> DUMP <<<<<<<<<<');
    debugDumpRenderTree();
  });

  testWidgets('PROVA 6: a receita oficial (ConstrainedBox + IntrinsicHeight)', (
    tester,
  ) async {
    Widget receita() => MaterialApp(
      home: Scaffold(
        body: LayoutBuilder(
          builder: (context, viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Container(height: 120, color: Colors.yellow),
                      Expanded(
                        child: Container(
                          height: 120,
                          color: Colors.red,
                          key: const Key('flex'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    // Tela grande: o Expanded ESTICA para preencher.
    await tester.pumpWidget(receita());
    expect(tester.takeException(), isNull);
    debugPrint(
      '>>> [tela 600px] Column altura: ${tester.getSize(find.byType(IntrinsicHeight)).height}',
    );
    debugPrint(
      '>>> [tela 600px] Expanded altura: ${tester.getSize(find.byKey(const Key('flex'))).height}',
    );

    // Tela pequena: o conteúdo não cabe -> ROLA, sem overflow.
    tester.view.physicalSize = const Size(400, 200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(receita());
    await tester.pump();
    expect(tester.takeException(), isNull);
    debugPrint(
      '>>> [tela 200px] Column altura: ${tester.getSize(find.byType(IntrinsicHeight)).height}',
    );
    debugPrint(
      '>>> [tela 200px] Expanded altura: ${tester.getSize(find.byKey(const Key('flex'))).height}',
    );
    debugPrint('>>> [tela 200px] Rolou sem overflow? SIM (sem exceção)');
  });

  testWidgets('PROVA 7: mainAxisAlignment.center NÃO funciona dentro do SCSV', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 100, color: Colors.blue, key: const Key('a')),
              ],
            ),
          ),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
    debugPrint(
      '>>> Altura do Column: ${tester.getSize(find.byType(Column)).height}',
    );
    debugPrint(
      '>>> Posição Y do filho: ${tester.getTopLeft(find.byKey(const Key('a'))).dy}',
    );
    debugPrint(
      '>>> (se center funcionasse, o Column teria 600 e o filho estaria em y=250)',
    );
  });
}

// * Sobe a árvore capturando os erros na fonte e devolve as linhas da PRIMEIRA
// * exceção — a causa raiz. As outras 12 são consequência dela.
Future<List<String>> _primeiroErro(WidgetTester tester, Widget app) async {
  final capturados = <FlutterErrorDetails>[];
  final anterior = FlutterError.onError;
  FlutterError.onError = capturados.add;
  await tester.pumpWidget(app);
  FlutterError.onError = anterior;
  return capturados.first.exception.toString().split('\n');
}

class _Spy extends StatelessWidget {
  const _Spy({
    required this.indice,
    required this.onBuild,
    required this.child,
  });
  final int indice;
  final ValueChanged<int> onBuild;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    onBuild(indice);
    return child;
  }
}

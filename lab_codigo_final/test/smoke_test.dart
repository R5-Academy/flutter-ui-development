import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scv_lab/exemplo_01_overflow_inicio.dart' as e01i;
import 'package:scv_lab/exemplo_02_01_armadilha_expanded_no_scroll.dart'
    as e02e;
import 'package:scv_lab/exemplo_02_02_constraint_inicio.dart' as e02i;
import 'package:scv_lab/exemplo_03_receita_inicio.dart' as e03i;
import 'package:scv_lab/exemplo_04_parametros_inicio.dart' as e04i;
import 'package:scv_lab/exemplo_05_constroi_tudo_inicio.dart' as e05i;

void main() {
  testWidgets('01 inicio DEVE dar overflow (esse é o ponto)', (tester) async {
    await tester.pumpWidget(const e01i.AppCadastro());
    final ex = tester.takeException();
    debugPrint(
      '>>> 01 inicio erro esperado: ${ex.toString().split('\n').first}',
    );
    expect(ex, isFlutterError);
  });

  testWidgets('01 completo NÃO pode dar overflow e DEVE rolar', (tester) async {
    expect(tester.takeException(), isNull);
    final scv = find.byType(SingleChildScrollView);
    expect(scv, findsOneWidget);
    await tester.drag(scv, const Offset(0, -300));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    debugPrint('>>> 01 completo rolou 300px sem exceção. OK');
  });

  testWidgets('02 errado explode com a mensagem do flex sem limite', (
    tester,
  ) async {
    // ! Um único erro de layout cascateia em vários. Capturamos na fonte com
    // ! FlutterError.onError para ver a PRIMEIRA — a que importa.
    final capturados = <FlutterErrorDetails>[];
    final anterior = FlutterError.onError;
    FlutterError.onError = capturados.add;
    await tester.pumpWidget(const e02e.AppExpandedErrado());
    FlutterError.onError = anterior;

    debugPrint('>>> 02 errado: ${capturados.length} exceções em cascata.');
    debugPrint('>>> 02 a PRIMEIRA (a causa raiz):');
    debugPrint(
      '>>> ${capturados.first.exception.toString().split('\n').first}',
    );
    expect(capturados, isNotEmpty);
    expect(
      capturados.first.exception.toString(),
      contains('non-zero flex but incoming height constraints are unbounded'),
    );
  });

  testWidgets('02 inicio sobe sem erro e ainda não mostra a constraint', (
    tester,
  ) async {
    await tester.pumpWidget(const e02i.AppConstraint());
    expect(tester.takeException(), isNull);
    expect(find.textContaining('Infinity'), findsNothing);
    debugPrint('>>> 02 inicio: sem a constraint na tela, como esperado. OK');
  });

  testWidgets('02 completo pinta a constraint infinita na tela', (
    tester,
  ) async {
    expect(tester.takeException(), isNull);
    expect(find.textContaining('Infinity'), findsWidgets);
    debugPrint('>>> 02 completo mostrou a constraint infinita na tela. OK');
  });

  testWidgets('03 inicio sobe sem erro, mas sem o piso do viewport', (
    tester,
  ) async {
    await tester.pumpWidget(const e03i.AppLogin());
    expect(tester.takeException(), isNull);
    expect(find.byType(IntrinsicHeight), findsNothing);
    debugPrint('>>> 03 inicio: sem IntrinsicHeight, como esperado. OK');
  });

  testWidgets('03 completo: sem erro em tela grande E em tela pequena', (
    tester,
  ) async {
    expect(tester.takeException(), isNull);
    final alturaGrande = tester.getSize(find.byType(IntrinsicHeight)).height;

    tester.view.physicalSize = const Size(400, 400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    final alturaPequena = tester.getSize(find.byType(IntrinsicHeight)).height;

    debugPrint(
      '>>> 03 tela 600 -> IntrinsicHeight: $alturaGrande (esticou até o piso)',
    );
    debugPrint(
      '>>> 03 tela 400 -> IntrinsicHeight: $alturaPequena (venceu o conteúdo, rola)',
    );
    expect(alturaPequena, greaterThan(alturaGrande - 200));
  });

  testWidgets('04 inicio: a faixa de cards estoura por falta do horizontal', (
    tester,
  ) async {
    await tester.pumpWidget(const e04i.AppParametros());
    // ! O overflow da Row é o problema que a aula conserta com
    // ! scrollDirection: Axis.horizontal.
    final ex = tester.takeException();
    debugPrint('>>> 04 inicio erro esperado: $ex');
    expect(ex.toString(), contains('overflowed'));

    final horizontais = tester
        .widgetList<SingleChildScrollView>(find.byType(SingleChildScrollView))
        .where((w) => w.scrollDirection == Axis.horizontal);
    debugPrint('>>> 04 inicio SCSVs horizontais: ${horizontais.length}');
    expect(horizontais, isEmpty);
  });

  testWidgets('04 completo tem horizontal + physics + teclado', (tester) async {
    expect(tester.takeException(), isNull);
    final todos = tester.widgetList<SingleChildScrollView>(
      find.byType(SingleChildScrollView),
    );
    final horizontais = todos.where(
      (w) => w.scrollDirection == Axis.horizontal,
    );
    final comTeclado = todos.where(
      (w) =>
          w.keyboardDismissBehavior == ScrollViewKeyboardDismissBehavior.onDrag,
    );
    debugPrint('>>> 04 completo SCSVs horizontais: ${horizontais.length}');
    debugPrint('>>> 04 completo SCSVs com onDrag: ${comTeclado.length}');
    expect(horizontais, isNotEmpty);
    expect(comTeclado, isNotEmpty);
  });

  testWidgets('05 inicio constrói todos os filhos declarados', (tester) async {
    await tester.pumpWidget(const e05i.AppConstroiTudo());
    await tester.pump();
    expect(tester.takeException(), isNull);
    final alturaColumn = tester
        .getSize(
          find.descendant(
            of: find.byType(SingleChildScrollView),
            matching: find.byType(Column),
          ),
        )
        .height;
    debugPrint('>>> 05 altura da Column com 1000 filhos: $alturaColumn px');
    debugPrint('>>> 05 altura da tela: 600 px');
    expect(alturaColumn, greaterThan(10000));
  });

  testWidgets('05 completo mostra o placar com TODOS construídos', (
    tester,
  ) async {
    // ! Dois pumps: no primeiro frame o painel é construído ANTES dos filhos,
    // ! então o contador ainda está zerado. O addPostFrameCallback dispara o
    // ! segundo frame, que já mostra o total somado.
    await tester.pump();
    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(find.textContaining('Filhos construídos: 1000'), findsOneWidget);
    debugPrint(
      '>>> 05 completo: placar confirmou 1000 builds para ~7 visíveis '
      '(itens de 64 px numa janela de 451).',
    );
  });
}

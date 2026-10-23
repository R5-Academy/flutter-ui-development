import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:minha_app/app/minha_app.dart';

void main() {
  testWidgets('a moldura tem AppBar, drawer e barra inferior', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MinhaApp());

    expect(find.widgetWithText(AppBar, 'Minha App'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);

    // O ☰ aparece sozinho porque o Scaffold tem um drawer.
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    expect(find.byType(Drawer), findsOneWidget);
    expect(find.text('usuario@email.com'), findsOneWidget);
  });

  testWidgets('a barra de baixo troca o destino', (WidgetTester tester) async {
    await tester.pumpWidget(const MinhaApp());

    expect(find.text('Página Inicial'), findsOneWidget);

    await tester.tap(find.text('Tarefas'));
    await tester.pumpAndSettle();

    expect(find.text('Minhas Tarefas'), findsOneWidget);
  });

  testWidgets('o IndexedStack preserva a tarefa marcada', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MinhaApp());

    await tester.tap(find.text('Tarefas'));
    await tester.pumpAndSettle();

    // A primeira tarefa nasce pendente.
    final primeiraCaixa = find.byType(Checkbox).first;
    expect(tester.widget<Checkbox>(primeiraCaixa).value, isFalse);

    await tester.tap(primeiraCaixa);
    await tester.pumpAndSettle();
    expect(tester.widget<Checkbox>(primeiraCaixa).value, isTrue);

    // Sai da aba e volta: a marcação sobrevive porque o body é um IndexedStack.
    await tester.tap(find.text('Perfil'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tarefas'));
    await tester.pumpAndSettle();

    expect(tester.widget<Checkbox>(find.byType(Checkbox).first).value, isTrue);
  });
}

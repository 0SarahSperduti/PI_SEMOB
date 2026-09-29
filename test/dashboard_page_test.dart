import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_ai/features/dashboard/pages/dashboard_page.dart';
import 'package:mobi_ai/shared/widgets/app_widgets.dart';

void main() {
  testWidgets('renderiza os KPIs e o filtro de período',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1600, 1800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: Scaffold(body: DashboardPage())),
      ),
    );

    expect(find.text('PASSAGEIROS DO DIA'), findsOneWidget);
    expect(find.text('RECEITA DO MÊS'), findsOneWidget);
    expect(find.byType(AppMetricCard), findsNWidgets(8));

    // Filtros de periodo disponiveis.
    expect(find.text('Período:'), findsOneWidget);
    expect(find.text('Hoje'), findsOneWidget);
    expect(find.text('Últimos 30d'), findsOneWidget);
    expect(find.text('Personalizado'), findsOneWidget);
  });

  testWidgets('ativa a comparacao entre períodos', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1600, 1800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: Scaffold(body: DashboardPage())),
      ),
    );

    await tester.tap(find.text('Comparar períodos'));
    await tester.pumpAndSettle();

    expect(find.textContaining('período anterior'), findsWidgets);
  });
}

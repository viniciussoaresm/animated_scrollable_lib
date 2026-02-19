import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:animated_scrollable/animated_scrollable.dart';

void main() {
  group('AnimatedScrollableScanfold Tests', () {
    testWidgets('Deve renderizar o header com a altura máxima inicial', (
      WidgetTester tester,
    ) async {
      const double expandedHeight = 200.0;

      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedScrollableScanfold(
            expandedHeight: expandedHeight,
            header: (context, offset, percent) => Container(
              key: const Key('header-content'),
              child: Text('Percent: $percent'),
            ),
            items: const [SizedBox(height: 1000, child: Text('Lista Longa'))],
          ),
        ),
      );

      // Verifica se o header está na tela
      final headerFinder = find.byKey(const Key('header-content'));
      expect(headerFinder, findsOneWidget);

      // Verifica a altura inicial do header
      final Size headerSize = tester.getSize(headerFinder);
      expect(headerSize.height, expandedHeight);

      // Verifica se o percentual inicial é 1.0 (totalmente expandido)
      expect(find.text('Percent: 1.0'), findsOneWidget);
    });

    testWidgets('Deve diminuir o header ao scrollar', (
      WidgetTester tester,
    ) async {
      const double expandedHeight = 200.0;
      const double collapsedHeight = 50.0;

      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedScrollableScanfold(
            expandedHeight: expandedHeight,
            collapsedHeight: collapsedHeight,
            header: (context, offset, percent) => Container(
              key: const Key('header-content'),
              child: Text('Percent: ${percent.toStringAsFixed(1)}'),
            ),
            items: List.generate(20, (i) => ListTile(title: Text('Item $i'))),
          ),
        ),
      );

      // Simula um scroll para cima de 100 pixels
      final scrollable = find.byType(CustomScrollView);
      await tester.drag(scrollable, const Offset(0, -100));
      await tester.pump(); // Atualiza o frame

      // O percent deve ter diminuído (200 - 100 / 150 de range)
      // Não deve ser mais 1.0
      expect(find.text('Percent: 1.0'), findsNothing);
    });

    testWidgets('Deve respeitar o bottomWidget fixo', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedScrollableScanfold(
            header: (context, offset, percent) => const SizedBox(),
            items: const [SizedBox(height: 1000)],
            bottomWidget: const Text('BOTÃO FIXO'),
          ),
        ),
      );

      expect(find.text('BOTÃO FIXO'), findsOneWidget);
    });
  });
}

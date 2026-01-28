
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:footnote/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app title is present
    expect(find.text('Footnote'), findsOneWidget);
  });
}

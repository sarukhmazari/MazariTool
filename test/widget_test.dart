// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mazari_tool/main.dart';

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MazariToolApp());

    // Check that "MAZARI TOOL" text appears
    expect(find.text('MAZARI TOOL'), findsOneWidget);

    // Check that "Get Started" button exists
    expect(find.text('Get Started'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('accessibility matchers', () {
    testWidgets('meetsGuideline iOSTapTargetGuideline ✅', (tester) async {
      final handle = tester.ensureSemantics();
      final content = SizedBox.square(
        dimension: 46.0,
        child: GestureDetector(onTap: () {}),
      );
      await tester.pumpWidget(MaterialApp(home: Center(child: content)));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      handle.dispose();
    });

    testWidgets('meetsGuideline androidTapTargetGuideline ❌', (tester) async {
      final handle = tester.ensureSemantics();
      final content = SizedBox.square(
        dimension: 46.0,
        child: GestureDetector(onTap: () {}),
      );
      await tester.pumpWidget(MaterialApp(home: Center(child: content)));
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      handle.dispose();
    });

    testWidgets('meetsGuideline textContrastGuideline (black) ✅',
        (tester) async {
      final handle = tester.ensureSemantics();
      final content = Container(
        color: Colors.white,
        child: Text(
          'Text contrast test',
          style: TextStyle(color: Colors.black),
        ),
      );
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: content)));
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });

    testWidgets('meetsGuideline textContrastGuideline (orange) ❌',
        (tester) async {
      final handle = tester.ensureSemantics();
      final content = Container(
        color: Colors.white,
        child: Text(
          'Text contrast test',
          style: TextStyle(color: Colors.deepOrange),
        ),
      );
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: content)));
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });

    testWidgets('meetsGuideline textContrastGuideline (orange big) ✅',
        (tester) async {
      final handle = tester.ensureSemantics();
      final content = Container(
        color: Colors.white,
        child: Text(
          'Text contrast test',
          style: TextStyle(
            fontSize: 20,
            color: Colors.deepOrange,
          ),
        ),
      );
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: content)));
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });
  });
}

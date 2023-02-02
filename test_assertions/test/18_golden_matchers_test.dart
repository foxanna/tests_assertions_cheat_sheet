import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('golden matchers', () {
    testWidgets('matchesReferenceImage ✅', (tester) async {
      final key = UniqueKey();
      final widget = Container(
        width: 200,
        height: 200,
        padding: EdgeInsets.all(20),
        child: ColoredBox(color: Colors.green),
      );
      final image = await createTestImage();
      await tester.pumpWidget(
        Center(
          child: RepaintBoundary(
            key: key,
            child: widget,
          ),
        ),
      );
      await expectLater(find.byKey(key), matchesReferenceImage(image));
    });

    testWidgets('matchesGoldenFile ✅', (tester) async {
      final widget = Container(
        width: 200,
        height: 200,
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: ColoredBox(color: Colors.blue),
      );
      await tester.pumpWidget(widget);
      await expectLater(
        find.byType(Container),
        matchesGoldenFile('18_golden_matchers_test.png'),
      );
    });
  });
}

Future<ui.Image> createTestImage() {
  final paint = ui.Paint()
    ..style = ui.PaintingStyle.fill
    ..color = Colors.green;
  final recorder = ui.PictureRecorder();
  final pictureCanvas = ui.Canvas(recorder);
  pictureCanvas.drawRect(Rect.fromLTWH(20, 20, 160, 160), paint);
  final picture = recorder.endRecording();
  return picture.toImage(200, 200);
}

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('expect function', () {
    test('expect (value) ✅', () {
      final result = 0;
      expect(result, 0);
    });

    test('expect (value) ❌', () {
      final result = 1;
      expect(result, 0);
    });

    test('expect (reason) ❌', () {
      final result = 1;
      expect(result, 0, reason: 'Result should be 0!');
    });

    test('expect (skip) ✅', () {
      final result = 1;
      expect(result, 0, skip: true);
      expect(result, 0, skip: 'for a reason');
    });
  });
}

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('numeric zero-oriented matchers', () {
    test('isZero ✅', () {
      final result = 0;
      expect(result, isZero);
    });

    test('isNonZero ✅', () {
      final result = 1;
      expect(result, isNonZero);
    });

    test('isPositive ✅', () {
      final result = 1;
      expect(result, isPositive);
    });

    test('isNonNegative ✅', () {
      final result = 1;
      expect(result, isNonNegative);
    });
  });

  group('numeric range matchers', () {
    test('inInclusiveRange ✅', () {
      final result = 1;
      expect(result, inInclusiveRange(0, 1));
    });

    test('inExclusiveRange ❌', () {
      final result = 1;
      expect(result, inExclusiveRange(0, 1));
    });
  });
}

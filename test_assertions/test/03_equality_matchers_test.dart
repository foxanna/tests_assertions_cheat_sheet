import 'package:flutter_test/flutter_test.dart';

void main() {
  group('same equality matcher', () {
    test('same (different objects) ❌', () {
      final result = Result(1);
      expect(result, same(Result(1)));
    });

    test('same (same object) ✅', () {
      final result = Result(1);
      expect(result, same(result));
    });

    test('same (const) ✅', () {
      const result = 1;
      expect(result, same(1));
    });

    test('same (different const objects) ✅', () {
      const result = Result(1);
      expect(result, same(const Result(1)));
    });
  });

  group('null equality matchers', () {
    test('isNull ❌', () {
      const result = 0;
      expect(result, isNull);
    });

    test('isNotNull ✅', () {
      const result = 0;
      expect(result, isNotNull);
    });
  });

  group('bool equality matchers', () {
    test('isTrue ✅', () {
      const result = 0;
      expect(result < 1, isTrue);
    });

    test('isFalse ✅', () {
      const result = 0;
      expect(result > 1, isFalse);
    });
  });
}

class Result {
  const Result(this.value);

  final int value;

  @override
  String toString() {
    return 'Result{value: $value}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Result &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

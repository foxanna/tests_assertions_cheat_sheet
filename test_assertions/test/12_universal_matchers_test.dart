import 'package:flutter_test/flutter_test.dart';

void main() {
  group('universal matcher', () {
    test('predicate ✅', () {
      final result = Result(0);
      expect(result, predicate((e) => e is Result && e.value == 0));
      expect(result, predicate<Result>((result) => result.value == 0));
    });

    test('predicate ❌', () {
      final result = 1;
      expect(result, predicate((e) => e == 0));
    });

    test('predicate (with description) ❌', () {
      final result = 1;
      expect(result, predicate((e) => e == 0, 'Result should be 0!'));
    });

    test('equals ❌', () {
      final result = 1;
      expect(result, equals(0));
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

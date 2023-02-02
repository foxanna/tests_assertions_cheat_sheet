import 'package:flutter_test/flutter_test.dart';

void main() {
  group('comparable matchers', () {
    test('greaterThan (int) ✅', () {
      final result = 1;
      expect(result, greaterThan(0));
    });

    test('lessThanOrEqualTo (int) ✅', () {
      final result = 1;
      expect(result, lessThanOrEqualTo(1));
    });

    test('greaterThan (custom type) ✅', () {
      final result = Result(1);
      expect(result, greaterThan(Result(0)));
    });

    test('lessThanOrEqualTo (custom type) ✅', () {
      final result = Result(1);
      expect(result, lessThanOrEqualTo(Result(1)));
    });

    test('greaterThan (custom type & int) ✅', () {
      final result = Result(1);
      expect(result, greaterThan(0));
    });

    test('lessThan (custom type & int) ✅', () {
      final result = Result(0);
      expect(result, lessThan(1));
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

  bool operator >(Object other) =>
      (other is Result && value > other.value) ||
      (other is int && value > other);

  bool operator <(Object other) =>
      (other is Result && value < other.value) ||
      (other is int && value < other);

  @override
  int get hashCode => value.hashCode;
}

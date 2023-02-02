import 'package:flutter_test/flutter_test.dart';

void main() {
  group('iterable predicate matchers', () {
    test('everyElement ✅', () {
      final result = [Result(0), Result(1)];
      expect(result, everyElement(isResult));
    });

    test('anyElement ✅', () {
      final result = {0, 1};
      expect(result, anyElement(0));
    });
  });

  group('iterable content matchers', () {
    test('containsAll ✅', () {
      final result = [Result(0), Result(1), Result(2)];
      expect(result, containsAll([Result(1), Result(0)]));
    });

    test('containsAllInOrder ✅', () {
      final result = {0, 1, 2};
      expect(result, containsAllInOrder({0, 1}));
    });

    test('orderedEquals ✅', () {
      final result = [Result(0), Result(1)];
      expect(result, orderedEquals([Result(0), Result(1)]));
    });

    test('unorderedEquals ✅', () {
      final result = {0, 1};
      expect(result, unorderedEquals({1, 0}));
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

const isResult = TypeMatcher<Result>();

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('matcher operators', () {
    test('allOf ✅', () {
      final result = Result(0);
      expect(result, allOf(hasValue(0), isResult));
      expect(result, allOf([hasValue(0), isResult]));
    });

    test('allOf ❌', () {
      final result = Result(0);
      expect(result, allOf([hasLength(1), hasValue(1)]));
    });

    test('anyOf ✅', () {
      final result = Result(0);
      expect(result, anyOf(hasLength(1), hasValue(0)));
      expect(result, anyOf([hasLength(1), hasValue(0)]));
    });

    test('isNot ✅', () {
      final result = 0;
      expect(result, isNot(1));
      expect(result, isNot(isResult));
      expect(result, isNot(allOf(isResult, hasValue(0))));
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

class HasValue extends CustomMatcher {
  HasValue(Object? valueOrMatcher)
      : super(
          'an object with value field of',
          'value field',
          valueOrMatcher,
        );

  @override
  Object? featureValueOf(dynamic actual) => actual.value;
}

Matcher hasValue(Object? valueOrMatcher) => HasValue(valueOrMatcher);

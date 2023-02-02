import 'package:flutter_test/flutter_test.dart';

void main() {
  group('custom matcher with value', () {
    test('HasValue ✅', () {
      final result = Result(0);
      expect(result, HasValue(0));
    });

    test('hasValue ✅', () {
      final result = Result(0);
      expect(result, hasValue(0));
    });

    test('hasValue ❌', () {
      final result = Result(1);
      expect(result, hasValue(0));
    });
  });

  group('custom matcher with matcher', () {
    test('hasValue (matcher) ✅', () {
      final result = Result(0);
      expect(result, hasValue(equals(0)));
      expect(result, hasValue(isZero));
      expect(result, hasValue(lessThan(1)));
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

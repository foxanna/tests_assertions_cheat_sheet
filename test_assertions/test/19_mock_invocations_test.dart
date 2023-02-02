import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('verify invocations', () {
    test('verify ❌', () {
      final mock = MockService();
      verify(() => mock.sideEffect(0));
    });

    test('verify (called) ❌', () {
      final mock = MockService();
      verify(() => mock.sideEffect(0)).called(1);
    });

    test('verifyNever ✅', () {
      final mock = MockService();
      verifyNever(() => mock.sideEffect(0));
    });
  });

  group('verify invocation parameters', () {
    test('any ✅', () {
      final mock = MockService()..sideEffect(0, result: Result(0));
      verify(() => mock.sideEffect(any(), result: any(named: 'result')));
    });

    test('verify ✅', () {
      final mock = MockService()..sideEffect(0, result: Result(0));
      verify(() => mock.sideEffect(0, result: Result(0)));
    });

    test('any (that) ✅', () {
      final mock = MockService()..sideEffect(0, result: Result(0));
      verify(() => mock.sideEffect(
            any(that: isZero),
            result: any(named: 'result', that: allOf(isResult, hasValue(0))),
          ));
    });
  });
}

abstract class Service {
  void sideEffect(int value, {Result? result});
}

class MockService extends Mock implements Service {}

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

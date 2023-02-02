import 'package:flutter_test/flutter_test.dart';

void main() {
  group('map matchers', () {
    test('containsValue ✅', () {
      final result = {0: Result(0)};
      expect(result, containsValue(Result(0)));
    });

    test('containsPair ✅', () {
      final result = {0: Result(0)};
      expect(result, containsPair(0, isResult));
      expect(result, containsPair(0, Result(0)));
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

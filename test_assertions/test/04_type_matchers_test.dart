import 'package:flutter_test/flutter_test.dart';

void main() {
  group('type matcher', () {
    test('isA ❌', () {
      const result = 0;
      expect(result, isA<Result>());
    });

    test('isA ✅', () {
      const result = 0;
      expect(result, isA<int>());
    });
  });

  group('predefined type matchers', () {
    test('isList ✅', () {
      final result = [0];
      expect(result, isList);
    });

    test('isMap ✅', () {
      final result = {0: const Result(0)};
      expect(result, isMap);
    });
  });

  group('custom type matchers', () {
    const isResult = TypeMatcher<Result>();

    test('isResult ✅', () {
      const result = Result(0);
      expect(result, isResult);
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

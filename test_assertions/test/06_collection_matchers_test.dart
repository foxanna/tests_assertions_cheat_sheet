import 'package:flutter_test/flutter_test.dart';

void main() {
  group('collection size matchers', () {
    test('isEmpty (array) ✅', () {
      final result = [];
      expect(result, isEmpty);
    });

    test('isEmpty (string) ❌', () {
      final result = '0';
      expect(result, isEmpty);
    });

    test('isNotEmpty (map) ✅', () {
      final result = {0: '0'};
      expect(result, isNotEmpty);
    });

    test('isEmpty (int) ❌', () {
      final result = 0;
      expect(result, isNotEmpty);
    });

    test('hasLength (string) ✅', () {
      final result = '0';
      expect(result, hasLength(1));
    });

    test('hasLength (int) ❌', () {
      final result = 0;
      expect(result, hasLength(1));
    });
  });

  group('collection content matchers', () {
    test('contains (substring) ✅', () {
      final result = 'result';
      expect(result, contains('res'));
    });

    test('contains (map key) ✅', () {
      final result = {0: Result(0)};
      expect(result, contains(0));
    });

    test('contains (iterable item) ✅', () {
      final result = [Result(0), Result(1)];
      expect(result, contains(predicate<Result>((r) => r.value == 0)));
      expect(result, contains(Result(1)));
    });

    test('isIn (string) ✅', () {
      final result = 'res';
      expect(result, isIn('result'));
    });

    test('isIn (iterable) ✅', () {
      final result = Result(0);
      expect(result, isIn([Result(0), Result(1)]));
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

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('string content matchers', () {
    test('startsWith ✅', () {
      final result = 'result';
      expect(result, startsWith('res'));
    });

    test('endsWith ✅', () {
      final result = 'result';
      expect(result, endsWith('ult'));
    });
  });

  group('string match matcher', () {
    test('matches (string) ✅', () {
      final result = 'result';
      expect(result, matches('esul'));
    });

    test('matches (regexp) ✅', () {
      final result = 'result';
      expect(result, matches(RegExp('r[a-z]{4}t')));
    });
  });
}

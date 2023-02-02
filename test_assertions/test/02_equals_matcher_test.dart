import 'package:flutter_test/flutter_test.dart';

void main() {
  group('equals matcher', () {
    test('equals (implicit) ✅', () {
      final result = 0;
      expect(result, 0);
    });

    test('equals (explicit) ✅', () {
      final result = 0;
      expect(result, equals(0));
    });

    test('equals (custom class) ✅', () {
      final result = Result(0);
      expect(result, equals(Result(0)));
    });
  });
}

class Result {
  Result(this.value);

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

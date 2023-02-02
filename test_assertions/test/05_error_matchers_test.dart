import 'package:flutter_test/flutter_test.dart';

void main() {
  group('error type matchers', () {
    test('isUnimplementedError ✅', () {
      final result = UnimplementedError();
      expect(result, isUnimplementedError);
    });

    test('isException ✅', () {
      final result = Exception();
      expect(result, isException);
    });
  });

  group('thrown error matcher', () {
    test('throwsA (isException) ✅', () {
      final resultFactory = () => throw Exception();
      expect(resultFactory, throwsA(isException));
    });

    test('throwsA (isNoSuchMethodError) ✅', () {
      final resultFactory = (int value) => (value as dynamic).length;
      expect(() => resultFactory(0), throwsA(isNoSuchMethodError));
    });
  });
}

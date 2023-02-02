import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('expectLater', () {
    test('expectLater ✅', () async {
      final result = Future.value(0);
      await expectLater(result, completes);
    });
  });

  group('future matchers', () {
    test('completion ✅', () async {
      final result = Future.value(0);
      await expectLater(result, completion(isZero));
    });

    test('throwsA ✅', () async {
      final result = Future.error(Exception());
      await expectLater(result, throwsA(isException));
    });
  });

  group('stream matchers', () {
    test('emits ✅', () {
      final stream = Stream.fromIterable([0]);
      expect(stream, emits(0));
      expect(stream, emits(isZero));
      expect(stream, emits((value) => value == 0));
      expect(stream, emits(predicate<int>((value) => value == 0)));
    });

    test('neverEmits ✅', () {
      final stream = Stream.fromIterable([1]);
      expect(stream, neverEmits(0));
      expect(stream, neverEmits(isZero));
      expect(stream, neverEmits((value) => value == 0));
      expect(stream, neverEmits(predicate<int>((value) => value == 0)));
    });

    test('emitsInOrder ✅', () {
      final stream = Stream.fromIterable([0, 1]);
      expect(stream, emitsInOrder([isZero, 1]));
    });

    test('emitsInAnyOrder ✅', () {
      final stream = Stream.fromIterable([Result(0), Result(1)]);
      expect(stream, emitsInAnyOrder([hasValue(1), Result(0)]));
    });

    test('emitsDone ✅', () {
      final stream = Stream.empty();
      expect(stream, emitsDone);
    });

    test('emitsError ✅', () {
      final stream = Stream.error(UnimplementedError());
      expect(stream, emitsError(isUnimplementedError));
    });
  });

  group('drained/closed streams', () {
    test('drained stream (expect) ⏳', () async {
      final streamExample = StreamExample();
      streamExample.doWork();
      expect(streamExample.stream, emitsInOrder([0, 1]));
    });

    test('drained stream (expectLater) ✅', () async {
      final streamExample = StreamExample();
      expectLater(streamExample.stream, emitsInOrder([0, 1]));
      streamExample.doWork();
    });
  });
}

class StreamExample {
  final _streamController = StreamController<int>.broadcast();

  void doWork() {
    _streamController.add(0);
    _streamController.add(1);
  }

  Stream<int> get stream => _streamController.stream;
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

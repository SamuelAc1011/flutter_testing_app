// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:testing_repository/testing_repository.dart';

void main() {
  group('TestingRepository', () {
    test('can be instantiated', () {
      expect(
        TestingRepository(
          'http://localhost:3000',
        ),
        isNotNull,
      );
    });
  });
}

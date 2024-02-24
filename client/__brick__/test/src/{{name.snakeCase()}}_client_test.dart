// ignore_for_file: prefer_const_constructors
import 'package:{{name.snakeCase()}}_client/{{name.snakeCase()}}_client.dart';
import 'package:test/fake.dart';
import 'package:test/test.dart';

class Fake{{name.pascalCase()}}Client extends Fake implements {{name.pascalCase()}}Client {}

void main() {
  group('{{name.pascalCase()}}Client', () {
    test('can be instantiated', () {
      expect(Fake{{name.pascalCase()}}Client.new, returnsNormally);
    });
  });
}

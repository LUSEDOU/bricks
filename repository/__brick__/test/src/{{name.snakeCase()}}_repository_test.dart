import 'package:{name.snakeCase()}_repository/{name.snakeCase()}_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class Mock{{name.pascalCase()}}Storage extends Mock implements {{name.pascalCase()}}Storage {}

void main() {
  group('{name.pascalCase()}Repository', () {
    late {{name.pascalCase()}}Storage storage;
    late {name.pascalCase()}Repository {name.camelCase()}Repository;

    setUp(() {
      storage = Mock{{name.pascalCase()}}Storage();

      {name.camelCase()}Repository = {name.pascalCase()}Repository(
        storage: storage,
      );
    });
  });
}

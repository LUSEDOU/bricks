part of '{name.snakeCase()}_repository.dart';

/// Storage keys for the [{{name.pascalCase()}}Storage].
abstract class {{name.pascalCase()}}StorageKeys {}

/// {@template {{name.snakeCase()}}_storage}
/// Storage for the [{{name.pascalCase()}}Repository].
/// {@endtemplate}
class {{name.pascalCase()}}Storage {
  /// {@macro {{name.snakeCase()}}_storage}
  const {{name.pascalCase()}}Storage({
    required Storage storage,
  }) : _storage = storage;

  final Storage _storage;
}

import 'package:equatable/equatable.dart';
import 'package:storage/storage.dart';

part '{{name.snakeCase()}}_failure.dart';
part '{{name.snakeCase()}}_storage.dart';

/// {@template {name.snakeCase()}_repository}
/// A repository that manages {{name.lowerCase()}} data.
/// {@endtemplate}
class {{name.pascalCase()}}Repository {
  /// {@macro {{name.snakeCase()}}_repository}
  const {{name.pascalCase()}}Repository({
    required {{name.pascalCase()}}Storage storage,
  })  : _storage = storage;

  final {{name.pascalCase()}}Storage _storage;
}

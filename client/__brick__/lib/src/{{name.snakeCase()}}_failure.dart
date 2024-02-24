part of '{{name.snakeCase()}}_client.dart';

/// {@template {{name.snakeCase()}}_failure}
/// Exception from the {{name.lowerCase()}} client.
/// {@endtemplate}
abstract class {{name.pascalCase()}}Failure with EquatableMixin implements Exception {
  /// {@macro {{name.snakeCase()}}_failure}
  const {{name.pascalCase()}}Failure(this.error);

  /// The error which was caught.
  final Object error;

  @override
  List<Object> get props => [error];
}

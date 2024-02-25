part of '{name.snakeCase()}_repository.dart';

/// Storage keys for the [{{name.pascalCase()}}Storage].
abstract class {{name.pascalCase()}}StorageKeys {
  /// The number of {{name.snakeCase()}} views.
  static const {{name.snakeCase()}}Views = '__{{name.snakeCase()}}_views_storage_key__';

  /// The date when the number of {{name.snakeCase()}} views was last reset.
  static const {{name.snakeCase()}}ViewsResetAt = '__{{name.snakeCase()}}_views_reset_at_storage_key__';

  /// Number of total {{name.snakeCase()}}s views.
  static const total{{name.pascalCase()}}Views = '__total_{{name.snakeCase()}}_views_key__';
}

/// {@template {{name.snakeCase()}}_storage}
/// Storage for the [{name.pascalCase()}Repository].
/// {@endtemplate}
class {{name.pascalCase()}}Storage {
  /// {@macro {{name.snakeCase()}}_storage}
  const {{name.pascalCase()}}Storage({
    required Storage storage,
  }) : _storage = storage;

  final Storage _storage;

  /// Sets the number of {{name.snakeCase()}} views in Storage.
  Future<void> set{{name.pascalCase()}}Views(int views) => _storage.write(
        key: {{name.pascalCase()}}StorageKeys.{{name.snakeCase()}}Views,
        value: views.toString(),
      );

  /// Fetches the number of {{name.snakeCase()}} views from Storage.
  Future<int> fetch{{name.pascalCase()}}Views() async {
    final {{name.snakeCase()}}Views =
        await _storage.read(key: {{name.pascalCase()}}StorageKeys.{{name.snakeCase()}}Views);
    return {{name.snakeCase()}}Views != null ? int.parse({{name.snakeCase()}}Views) : 0;
  }

  /// Sets the reset date of the number of {{name.snakeCase()}} views in Storage.
  Future<void> set{{name.pascalCase()}}ViewsResetDate(DateTime date) => _storage.write(
        key: {{name.pascalCase()}}StorageKeys.{{name.snakeCase()}}ViewsResetAt,
        value: date.toIso8601String(),
      );

  /// Fetches the reset date of the number of {{name.snakeCase()}} views from Storage.
  Future<DateTime?> fetch{{name.pascalCase()}}ViewsResetDate() async {
    final resetDate =
        await _storage.read(key: {{name.pascalCase()}}StorageKeys.{{name.snakeCase()}}ViewsResetAt);
    return resetDate != null ? DateTime.parse(resetDate) : null;
  }

  /// Sets the number of total {{name.snakeCase()}} views.
  Future<void> setTotal{{name.pascalCase()}}Views(int count) => _storage.write(
        key: {{name.pascalCase()}}StorageKeys.total{{name.pascalCase()}}Views,
        value: count.toString(),
      );

  /// Fetches the number of total {{name.snakeCase()}} views value from storage.
  Future<int> fetchTotal{{name.pascalCase()}}Views() async {
    final count =
        await _storage.read(key: {{name.pascalCase()}}StorageKeys.total{{name.pascalCase()}}Views);
    return int.tryParse(count ?? '') ?? 0;
  }
}

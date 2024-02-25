part of '{name.snakeCase()}_repository.dart';

/// Storage keys for the [{{name.pascalCase()}}Storage].
abstract class {{name.pascalCase()}}StorageKeys {
  /// The number of article views.
  static const articleViews = '__article_views_storage_key__';

  /// The date when the number of article views was last reset.
  static const articleViewsResetAt = '__article_views_reset_at_storage_key__';

  /// Number of total articles views.
  static const total{{name.pascalCase()}}Views = '__total_article_views_key__';
}

/// {@template article_storage}
/// Storage for the [{name.pascalCase()}Repository].
/// {@endtemplate}
class {{name.pascalCase()}}Storage {
  /// {@macro article_storage}
  const {{name.pascalCase()}}Storage({
    required Storage storage,
  }) : _storage = storage;

  final Storage _storage;

  /// Sets the number of article views in Storage.
  Future<void> set{{name.pascalCase()}}Views(int views) => _storage.write(
        key: {{name.pascalCase()}}StorageKeys.articleViews,
        value: views.toString(),
      );

  /// Fetches the number of article views from Storage.
  Future<int> fetch{{name.pascalCase()}}Views() async {
    final articleViews =
        await _storage.read(key: {{name.pascalCase()}}StorageKeys.articleViews);
    return articleViews != null ? int.parse(articleViews) : 0;
  }

  /// Sets the reset date of the number of article views in Storage.
  Future<void> set{{name.pascalCase()}}ViewsResetDate(DateTime date) => _storage.write(
        key: {{name.pascalCase()}}StorageKeys.articleViewsResetAt,
        value: date.toIso8601String(),
      );

  /// Fetches the reset date of the number of article views from Storage.
  Future<DateTime?> fetch{{name.pascalCase()}}ViewsResetDate() async {
    final resetDate =
        await _storage.read(key: {{name.pascalCase()}}StorageKeys.articleViewsResetAt);
    return resetDate != null ? DateTime.parse(resetDate) : null;
  }

  /// Sets the number of total article views.
  Future<void> setTotal{{name.pascalCase()}}Views(int count) => _storage.write(
        key: {{name.pascalCase()}}StorageKeys.total{{name.pascalCase()}}Views,
        value: count.toString(),
      );

  /// Fetches the number of total article views value from storage.
  Future<int> fetchTotal{{name.pascalCase()}}Views() async {
    final count =
        await _storage.read(key: {{name.pascalCase()}}StorageKeys.total{{name.pascalCase()}}Views);
    return int.tryParse(count ?? '') ?? 0;
  }
}

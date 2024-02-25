import 'package:clock/clock.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_example_api/client.dart';
import 'package:storage/storage.dart';

part 'article_storage.dart';

/// {@template article_failure}
/// A base failure for the article repository failures.
/// {@endtemplate}
abstract class {{name.pascalCase()}}Failure with EquatableMixin implements Exception {
  /// {@macro article_failure}
  const {{name.pascalCase()}}Failure(this.error);

  /// The error which was caught.
  final Object error;

  @override
  List<Object> get props => [error];
}

/// {@template get_article_failure}
/// Thrown when fetching an article fails.
/// {@endtemplate}
class Get{{name.pascalCase()}}Failure extends {{name.pascalCase()}}Failure {
  /// {@macro get_article_failure}
  const Get{{name.pascalCase()}}Failure(super.error);
}

/// {@template get_related_articles_failure}
/// Thrown when fetching related articles fails.
/// {@endtemplate}
class GetRelated{{name.pascalCase()}}sFailure extends {{name.pascalCase()}}Failure {
  /// {@macro get_related_articles_failure}
  const GetRelated{{name.pascalCase()}}sFailure(super.error);
}

/// {@template increment_article_views_failure}
/// Thrown when incrementing article views fails.
/// {@endtemplate}
class Increment{{name.pascalCase()}}ViewsFailure extends {{name.pascalCase()}}Failure {
  /// {@macro increment_article_views_failure}
  const Increment{{name.pascalCase()}}ViewsFailure(super.error);
}

/// {@template decrement_article_views_failure}
/// Thrown when decrementing article views fails.
/// {@endtemplate}
class Decrement{{name.pascalCase()}}ViewsFailure extends {{name.pascalCase()}}Failure {
  /// {@macro decrement_article_views_failure}
  const Decrement{{name.pascalCase()}}ViewsFailure(super.error);
}

/// {@template reset_article_views_failure}
/// Thrown when resetting article views fails.
/// {@endtemplate}
class Reset{{name.pascalCase()}}ViewsFailure extends {{name.pascalCase()}}Failure {
  /// {@macro reset_article_views_failure}
  const Reset{{name.pascalCase()}}ViewsFailure(super.error);
}

/// {@template fetch_article_views_failure}
/// Thrown when fetching article views fails.
/// {@endtemplate}
class Fetch{{name.pascalCase()}}ViewsFailure extends {{name.pascalCase()}}Failure {
  /// {@macro fetch_article_views_failure}
  const Fetch{{name.pascalCase()}}ViewsFailure(super.error);
}

/// {@template increment_total_article_views_failure}
/// Thrown when incrementing total article views fails.
/// {@endtemplate}
class IncrementTotal{{name.pascalCase()}}ViewsFailure extends {{name.pascalCase()}}Failure {
  /// {@macro increment_total_article_views_failure}
  const IncrementTotal{{name.pascalCase()}}ViewsFailure(super.error);
}

/// {@template fetch_total_article_views_failure}
/// Thrown when fetching total article views fails.
/// {@endtemplate}
class FetchTotal{{name.pascalCase()}}ViewsFailure extends {{name.pascalCase()}}Failure {
  /// {@macro fetch_total_article_views_failure}
  const FetchTotal{{name.pascalCase()}}ViewsFailure(super.error);
}

/// {@template article_views}
/// Represents the number of article views and the date
/// when the number of article views was last reset.
/// {@endtemplate}
class {{name.pascalCase()}}Views {
  /// {@macro article_views}
  {{name.pascalCase()}}Views(this.views, this.resetAt);

  /// The number of article views.
  final int views;

  /// The date when the number of article views was last reset.
  final DateTime? resetAt;
}

/// {@template {name.snakeCase()}_repository}
/// A repository that manages article data.
/// {@endtemplate}
class {name.pascalCase()}Repository {
  /// {@macro {name.snakeCase()}_repository}
  const {name.pascalCase()}Repository({
    required FlutterNewsExampleApiClient apiClient,
    required {{name.pascalCase()}}Storage storage,
  })  : _apiClient = apiClient,
        _storage = storage;

  final FlutterNewsExampleApiClient _apiClient;
  final {{name.pascalCase()}}Storage _storage;

  /// Requests article content metadata.
  ///
  /// Supported parameters:
  /// * [id] - {{name.pascalCase()}} id for which content is requested.
  /// * [limit] - The number of results to return.
  /// * [offset] - The (zero-based) offset of the first item
  /// in the collection to return.
  /// * [preview] - Whether to return a preview of the article.
  Future<{{name.pascalCase()}}Response> get{{name.pascalCase()}}({
    required String id,
    int? limit,
    int? offset,
    bool preview = false,
  }) async {
    try {
      return await _apiClient.get{{name.pascalCase()}}(
        id: id,
        limit: limit,
        offset: offset,
        preview: preview,
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(Get{{name.pascalCase()}}Failure(error), stackTrace);
    }
  }

  /// Requests related articles.
  ///
  /// Supported parameters:
  /// * [id] - {{name.pascalCase()}} id for which related content is requested.
  /// * [limit] - The number of results to return.
  /// * [offset] - The (zero-based) offset of the first item
  /// in the collection to return.
  Future<Related{{name.pascalCase()}}sResponse> getRelated{{name.pascalCase()}}s({
    required String id,
    int? limit,
    int? offset,
  }) async {
    try {
      return await _apiClient.getRelated{{name.pascalCase()}}s(
        id: id,
        limit: limit,
        offset: offset,
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(GetRelated{{name.pascalCase()}}sFailure(error), stackTrace);
    }
  }

  /// Increments the number of article views by 1.
  Future<void> increment{{name.pascalCase()}}Views() async {
    try {
      final current{{name.pascalCase()}}Views = await _storage.fetch{{name.pascalCase()}}Views();
      await _storage.set{{name.pascalCase()}}Views(current{{name.pascalCase()}}Views + 1);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        Increment{{name.pascalCase()}}ViewsFailure(error),
        stackTrace,
      );
    }
  }

  /// Decrements the number of article views by 1.
  Future<void> decrement{{name.pascalCase()}}Views() async {
    try {
      final current{{name.pascalCase()}}Views = await _storage.fetch{{name.pascalCase()}}Views();
      await _storage.set{{name.pascalCase()}}Views(current{{name.pascalCase()}}Views - 1);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        Decrement{{name.pascalCase()}}ViewsFailure(error),
        stackTrace,
      );
    }
  }

  /// Resets the number of article views.
  Future<void> reset{{name.pascalCase()}}Views() async {
    try {
      await Future.wait([
        _storage.set{{name.pascalCase()}}Views(0),
        _storage.set{{name.pascalCase()}}ViewsResetDate(clock.now()),
      ]);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        Reset{{name.pascalCase()}}ViewsFailure(error),
        stackTrace,
      );
    }
  }

  /// Fetches the number of article views.
  Future<{{name.pascalCase()}}Views> fetch{{name.pascalCase()}}Views() async {
    try {
      late int views;
      late DateTime? resetAt;
      await Future.wait([
        (() async => views = await _storage.fetch{{name.pascalCase()}}Views())(),
        (() async => resetAt = await _storage.fetch{{name.pascalCase()}}ViewsResetDate())(),
      ]);
      return {{name.pascalCase()}}Views(views, resetAt);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        Fetch{{name.pascalCase()}}ViewsFailure(error),
        stackTrace,
      );
    }
  }

  /// Increments the number of total article views by 1.
  Future<void> incrementTotal{{name.pascalCase()}}Views() async {
    try {
      final total{{name.pascalCase()}}Views = await _storage.fetchTotal{{name.pascalCase()}}Views();
      await _storage.setTotal{{name.pascalCase()}}Views(total{{name.pascalCase()}}Views + 1);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        IncrementTotal{{name.pascalCase()}}ViewsFailure(error),
        stackTrace,
      );
    }
  }

  /// Fetches the number of total article views.
  Future<int> fetchTotal{{name.pascalCase()}}Views() async {
    try {
      return await _storage.fetchTotal{{name.pascalCase()}}Views();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        FetchTotal{{name.pascalCase()}}ViewsFailure(error),
        stackTrace,
      );
    }
  }
}

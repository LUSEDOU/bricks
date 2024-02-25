import 'package:clock/clock.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_example_api/client.dart';
import 'package:storage/storage.dart';

part '{{name.snakeCase()}}_storage.dart';



/// {@template {name.snakeCase()}_repository}
/// A repository that manages {{name.snakeCase()}} data.
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

  /// Requests {{name.snakeCase()}} content metadata.
  ///
  /// Supported parameters:
  /// * [id] - {{name.pascalCase()}} id for which content is requested.
  /// * [limit] - The number of results to return.
  /// * [offset] - The (zero-based) offset of the first item
  /// in the collection to return.
  /// * [preview] - Whether to return a preview of the {{name.snakeCase()}}.
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

  /// Requests related {{name.snakeCase()}}s.
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

  /// Increments the number of {{name.snakeCase()}} views by 1.
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

  /// Decrements the number of {{name.snakeCase()}} views by 1.
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

  /// Resets the number of {{name.snakeCase()}} views.
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

  /// Fetches the number of {{name.snakeCase()}} views.
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

  /// Increments the number of total {{name.snakeCase()}} views by 1.
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

  /// Fetches the number of total {{name.snakeCase()}} views.
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

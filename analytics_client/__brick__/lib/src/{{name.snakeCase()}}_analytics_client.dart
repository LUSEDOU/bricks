import 'package:analytics_client/analytics_client.dart';
import 'package:{{package.snakeCase()}}/{{package.snakeCase()}}.dart';

/// {@template {{name.snakeCase()}}_analytics_client}
/// A {{name.titleCase()}} implementation of the [AnalyticsClient] interface.
/// {@endtemplate}
class {{name.pascalCase()}}AnalyticsClient implements AnalyticsClient {
  /// {@macro {{name.snakeCase()}}_analytics_client}
  const {{name.pascalCase()}}AnalyticsClient({
    required {{package.pascalCase()}} {{package.camelCase()}},
  }) : _{{package.camelCase()}} = {{package.camelCase()}};

  final {{package.pascalCase()}} _{{package.camelCase()}};

  /// Tracks the given [event].
  ///
  /// Throws a [TrackEventFailure] if the event could not be tracked.
  @override
  Future<void> track(AnalyticsEvent event) async {
    try {
      /// TODO: Implement tracking logic here.
    } on TrackEventFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(TrackEventFailure(error), stackTrace);
    }
  }

  /// Sets the user identifier.
  ///
  /// Throws a [SetUserIdFailure] if the user identifier could not be set.
  @override
  Future<void> setUserId(String? userId) async {
    try {
      /// TODO: Implement set user id logic here.
    } on SetUserIdFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SetUserIdFailure(error), stackTrace);
    }
  }

  /// Sets the user properties.
  ///
  /// Throws a [SetUserPropertiesFailure] if the user properties
  /// could not be set.
  @override
  Future<void> setUserProperties(Map<String, dynamic> properties) async {
    try {
      /// TODO: Implement set user properties logic here.
    } on SetUserPropertiesFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SetUserPropertiesFailure(error), stackTrace);
    }
  }

  /// Tracks a screen view.
  ///
  /// Throws a [ScreenViewFailure] if the screen view could not be tracked.
  @override
  Future<void> screenView(String screen) async {
    try {
      /// TODO: Implement screen view logic here.
    } on ScreenViewFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(ScreenViewFailure(error), stackTrace);
    }
  }
}

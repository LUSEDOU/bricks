import 'package:analytics_client/analytics_client.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

/// {@template firebase_analytics_client}
/// A Firebase implementation of the [AnalyticsClient] interface.
/// {@endtemplate}
class FirebaseAnalyticsClient implements AnalyticsClient {
  /// {@macro firebase_analytics_client}
  const FirebaseAnalyticsClient({
    required FirebaseAnalytics firebaseAnalytics,
  }) : _firebaseAnalytics = firebaseAnalytics;

  final FirebaseAnalytics _firebaseAnalytics;

  /// Tracks the given [event].
  ///
  /// Throws a [TrackEventFailure] if the event could not be tracked.
  @override
  Future<void> track(AnalyticsEvent event) async {
    try {
      if (event.properties?.isNotEmpty ?? false) {
        _checkProperties(event.properties!);
      }

      await _firebaseAnalytics.logEvent(
        name: event.name,
        parameters: event.properties,
      );
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
      await _firebaseAnalytics.setUserId(id: userId);
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
      for (final entry in properties.entries) {
        await _firebaseAnalytics.setUserProperty(
          name: entry.key,
          value: entry.value.toString(),
        );
      }
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SetUserPropertiesFailure(error), stackTrace);
    }
  }

  /// Firebase handles this automatically without the need to call this method.
  @override
  Future<void> screenView(String screen) async {}

  /// Checks if the given [properties] are valid.
  ///
  /// A property is valid if it's length is less than or equal to 25
  /// and it's value is of type double, int or String.
  /// Throws an [Exception] if the properties are invalid.
  void _checkProperties(Map<String, dynamic> properties) {
    if (properties.length > 25) {
      throw Exception(
        'The maximum number of properties is 25.',
      );
    }
    if (properties.values.any(
      (value) => value is! double && value is! int && value is! String,
    )) {
      throw Exception(
        'The property values must be of type double, int or String.',
      );
    }
  }
}

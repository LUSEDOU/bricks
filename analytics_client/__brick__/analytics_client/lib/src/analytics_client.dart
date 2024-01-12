import 'package:analytics_client/analytics_client.dart';
import 'package:equatable/equatable.dart';

part 'analytics_failure.dart';

/// A generic Analytics Interface.
abstract class AnalyticsClient {
  /// Tracks the given [event].
  ///
  /// Throws a [TrackEventFailure] if the event could not be tracked.
  Future<void> track(AnalyticsEvent event);

  /// Sets the user identifier.
  ///
  /// Throws a [SetUserIdFailure] if the user identifier could not be set.
  Future<void> setUserId(String? userId);


  /// Sets the user properties.
  ///
  /// Throws a [SetUserPropertiesFailure] if the user properties
  /// could not be set.
  Future<void> setUserProperties(Map<String, dynamic> properties);

  /// Tracks a screen view.
  ///
  /// Throws a [ScreenViewFailure] if the screen view could not be tracked.
  Future<void> screenView(String screen);
}

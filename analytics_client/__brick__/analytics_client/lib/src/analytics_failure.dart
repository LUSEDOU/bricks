part of 'analytics_client.dart';

/// {@template analytics_failure}
/// Exception from the analytics client.
/// {@endtemplate}
abstract class AnalyticsFailure with EquatableMixin implements Exception {
  /// {@macro analytics_failure}
  const AnalyticsFailure(this.error);

  /// The error which was caught.
  final Object error;

  @override
  List<Object> get props => [error];
}

/// {@template track_event_failure}
/// Thrown when tracking an event fails.
/// {@endtemplate}
class TrackEventFailure extends AnalyticsFailure {
  /// {@macro track_event_failure}
  const TrackEventFailure(super.error);
}

/// {@template set_user_id_failure}
/// Thrown when setting the user identifier fails.
/// {@endtemplate}
class SetUserIdFailure extends AnalyticsFailure {
  /// {@macro set_user_id_failure}
  const SetUserIdFailure(super.error);
}

/// {@template set_user_properties_failure}
/// Thrown when setting the user properties fails.
/// {@endtemplate}
class SetUserPropertiesFailure extends AnalyticsFailure {
  /// {@macro set_user_properties_failure}
  const SetUserPropertiesFailure(super.error);
}

/// {@template screen_view_failure}
/// Thrown when a screen view fails.
/// {@endtemplate}
class ScreenViewFailure extends AnalyticsFailure {
  /// {@macro screen_view_failure}
  const ScreenViewFailure(super.error);
}

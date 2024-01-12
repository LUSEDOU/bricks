import 'package:equatable/equatable.dart';

/// {@template analytics_event}
/// An analytic event which can be tracked.
///
/// Consist of the unique event name an a optional map of properties.
/// {@endtemplate}
class AnalyticsEvent extends Equatable {
  /// {@macro analytics_event}
  const AnalyticsEvent(this.name, {this.properties});

  /// The unique event name.
  final String name;

  /// Optional properties which can be tracked with the event.
  final Map<String, dynamic>? properties;

  @override
  List<Object?> get props => [name, properties];
}

/// {@template analytics_event_mixin}
/// Mixin which can be used to implement the [AnalyticsEvent] class.
/// {@endtemplate}
mixin AnalyticsEventMixin on Equatable {
  /// The unique event name.
  AnalyticsEvent get event;

  @override
  List<Object> get props => [event];
}

part of 'analytics_repository.dart';

/// {@template analytics_failure}
/// A base failure for the analytics repository failures.
/// {@endtemplate}
abstract class AnalyticsFailure with EquatableMixin implements Exception {
  /// {@macro analytics_failure}
  const AnalyticsFailure(this.error);

  /// The error which was caught.
  final Object error;

  @override
  List<Object> get props => [error];
}

// ignore_for_file: prefer_const_constructors
import 'package:analytics_client/analytics_client.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics_client/firebase_analytics_client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

class MockAnalyticsEvent extends Mock implements AnalyticsEvent {}

void main() {
  group('FirebaseClient', () {
    late FirebaseAnalyticsClient client;
    late FirebaseAnalytics firebaseAnalytics;
    late AnalyticsEvent event;

    setUp(() {
      firebaseAnalytics = MockFirebaseAnalytics();
      client = FirebaseAnalyticsClient(firebaseAnalytics: firebaseAnalytics);
      event = MockAnalyticsEvent();
    });

    group('track', () {
      test(
          'throws an TrackEventFailure when properties length '
          'is greather than 25', () {
        final properties = <String, dynamic>{};
        for (var i = 0; i < 26; i++) {
          properties['key$i'] = 'value$i';
        }

        when(() => event.properties).thenReturn(properties);

        expect(
          () => client.track(event),
          throwsA(isA<TrackEventFailure>()),
        );
      });

      test('throws an TrackEventFailure when is not a valid type', () {
        when(() => event.properties).thenReturn(<String, dynamic>{
          'key': Object(),
        });

        expect(
          () => client.track(event),
          throwsA(isA<TrackEventFailure>()),
        );
      });
    });

    group('setUserId', () {});

    group('setUserProperties', () {});

    group('screenView', () {});
  });
}

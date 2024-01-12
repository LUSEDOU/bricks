// ignore_for_file: prefer_const_constructors
import 'package:analytics_client/analytics_client.dart';
import 'package:test/fake.dart';
import 'package:test/test.dart';

class FakeAnalyticsFailure extends Fake implements AnalyticsFailure {}

void main() {
  group('AnalyticsFailure', () {
    test('can be instantiated', () {
      expect(FakeAnalyticsFailure.new, returnsNormally);
    });
  });

  test('exports TrackEventFailure', () {
    expect(
      () => TrackEventFailure,
      returnsNormally,
    );
  });

  test('exports SetUserIdFailure', () {
    expect(
      () => SetUserIdFailure,
      returnsNormally,
    );
  });

  test('exports SetUserPropertiesFailure', () {
    expect(
      () => SetUserPropertiesFailure,
      returnsNormally,
    );
  });

  test('exports ScreenViewFailure', () {
    expect(
      () => ScreenViewFailure,
      returnsNormally,
    );
  });
}

// ignore_for_file: prefer_const_constructors
import 'package:analytics_client/analytics_client.dart';
import 'package:test/fake.dart';
import 'package:test/test.dart';

class FakeAnalyticsClient extends Fake implements AnalyticsClient {}

void main() {
  group('AnalyticsClient', () {
    test('can be instantiated', () {
      expect(FakeAnalyticsClient.new, returnsNormally);
    });
  });
}

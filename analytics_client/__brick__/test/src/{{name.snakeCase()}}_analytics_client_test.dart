// ignore_for_file: prefer_const_constructors
import 'package:{{name.snakeCase()}}_analytics_client/{{name.snakeCase()}}_analytics_client.dart';
import 'package:{{package.snakeCase()}}/{{package.snakeCase()}}.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class Mock{{package.pascalCase()}} extends Mock implements {{package.pascalCase()}} {}

void main() {
  group('{{name.pascalCase()}}Client', () {
    late {{name.pascalCase()}}AnalyticsClient client;
    late {{package.pascalCase()}} {{package.camelCase()}};

    setUp(() {
      {{package.camelCase()}} = Mock{{package.pascalCase()}}();
      client = {{name.pascalCase()}}AnalyticsClient({{package.camelCase()}}: {{package.camelCase()}});
    });

    group('track', () {
      setUp(() {
      });
    });

    group('setUserId', () {
      setUp(() {
      });
    });

    group('setUserProperties', () {
      setUp(() {
      });
    });

    group('screenView', () {
      setUp(() {
      });
    });
  });
}


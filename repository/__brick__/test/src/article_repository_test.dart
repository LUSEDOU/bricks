import 'package:{name.snakeCase()}_repository/{name.snakeCase()}_repository.dart';
import 'package:clock/clock.dart';
import 'package:flutter_news_example_api/client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockFlutterNewsExampleApiClient extends Mock
    implements FlutterNewsExampleApiClient {}

class Mock{{name.pascalCase()}}Storage extends Mock implements {{name.pascalCase()}}Storage {}

void main() {
  group('{name.pascalCase()}Repository', () {
    late FlutterNewsExampleApiClient apiClient;
    late {{name.pascalCase()}}Storage storage;
    late {name.pascalCase()}Repository {name.camelCase()}Repository;

    setUp(() {
      apiClient = MockFlutterNewsExampleApiClient();
      storage = Mock{{name.pascalCase()}}Storage();
      when(() => storage.set{{name.pascalCase()}}Views(any())).thenAnswer((_) async {});
      when(() => storage.set{{name.pascalCase()}}ViewsResetDate(any()))
          .thenAnswer((_) async {});

      {name.camelCase()}Repository = {name.pascalCase()}Repository(
        apiClient: apiClient,
        storage: storage,
      );
    });

    group('get{{name.pascalCase()}}', () {
      test(
          'returns {{name.pascalCase()}}Response '
          'from ApiClient.get{{name.pascalCase()}}', () {
        const content = <NewsBlock>[
          TextCaptionBlock(text: 'text', color: TextCaptionColor.normal),
          TextParagraphBlock(text: 'text'),
        ];

        final articleResponse = {{name.pascalCase()}}Response(
          title: 'title',
          content: content,
          totalCount: content.length,
          url: Uri.parse('https://www.dglobe.com/'),
          isPremium: false,
          isPreview: false,
        );

        when(
          () => apiClient.get{{name.pascalCase()}}(
            id: any(named: 'id'),
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
            preview: any(named: 'preview'),
          ),
        ).thenAnswer((_) async => articleResponse);

        expect(
          {name.camelCase()}Repository.get{{name.pascalCase()}}(
            id: 'id',
            offset: 10,
            limit: 20,
          ),
          completion(equals(articleResponse)),
        );

        verify(
          () => apiClient.get{{name.pascalCase()}}(
            id: 'id',
            offset: 10,
            limit: 20,
          ),
        ).called(1);
      });

      test(
          'throws Get{{name.pascalCase()}}Failure '
          'if ApiClient.get{{name.pascalCase()}} fails', () async {
        when(
          () => apiClient.get{{name.pascalCase()}}(
            id: any(named: 'id'),
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenThrow(Exception);

        expect(
          () => {name.camelCase()}Repository.get{{name.pascalCase()}}(id: 'id'),
          throwsA(isA<Get{{name.pascalCase()}}Failure>()),
        );
      });
    });

    group('getRelated{{name.pascalCase()}}s', () {
      test(
          'returns Related{{name.pascalCase()}}sResponse '
          'from ApiClient.getRelated{{name.pascalCase()}}s', () async {
        const related{{name.pascalCase()}}sResponse = Related{{name.pascalCase()}}sResponse(
          related{{name.pascalCase()}}s: [
            SpacerBlock(spacing: Spacing.extraLarge),
            DividerHorizontalBlock(),
          ],
          totalCount: 2,
        );

        when(
          () => apiClient.getRelated{{name.pascalCase()}}s(
            id: any(named: 'id'),
          ),
        ).thenAnswer((_) async => related{{name.pascalCase()}}sResponse);

        final response = await {name.camelCase()}Repository.getRelated{{name.pascalCase()}}s(id: 'id');

        expect(response, equals(related{{name.pascalCase()}}sResponse));
      });

      test(
          'throws GetRelated{{name.pascalCase()}}sFailure '
          'if ApiClient.getRelated{{name.pascalCase()}}s fails', () async {
        when(
          () => apiClient.getRelated{{name.pascalCase()}}s(
            id: any(named: 'id'),
          ),
        ).thenThrow(Exception());

        expect(
          {name.camelCase()}Repository.getRelated{{name.pascalCase()}}s(id: 'id'),
          throwsA(isA<GetRelated{{name.pascalCase()}}sFailure>()),
        );
      });
    });

    group('increment{{name.pascalCase()}}Views', () {
      test(
          'calls {{name.pascalCase()}}Storage.set{{name.pascalCase()}}Views '
          'with current article views increased by 1', () async {
        const current{{name.pascalCase()}}Views = 3;
        when(storage.fetch{{name.pascalCase()}}Views)
            .thenAnswer((_) async => current{{name.pascalCase()}}Views);

        await {name.camelCase()}Repository.increment{{name.pascalCase()}}Views();

        verify(storage.fetch{{name.pascalCase()}}Views).called(1);
        verify(() => storage.set{{name.pascalCase()}}Views(current{{name.pascalCase()}}Views + 1))
            .called(1);
      });

      test(
          'throws an Increment{{name.pascalCase()}}ViewsFailure '
          'when incrementing article views fails', () async {
        when(() => storage.set{{name.pascalCase()}}Views(any())).thenThrow(Exception());

        expect(
          () => {name.camelCase()}Repository.increment{{name.pascalCase()}}Views(),
          throwsA(isA<Increment{{name.pascalCase()}}ViewsFailure>()),
        );
      });
    });

    group('decrement{{name.pascalCase()}}Views', () {
      test(
          'calls {{name.pascalCase()}}Storage.set{{name.pascalCase()}}Views '
          'with current article views decreased by 1', () async {
        const current{{name.pascalCase()}}Views = 3;
        when(storage.fetch{{name.pascalCase()}}Views)
            .thenAnswer((_) async => current{{name.pascalCase()}}Views);

        await {name.camelCase()}Repository.decrement{{name.pascalCase()}}Views();

        verify(storage.fetch{{name.pascalCase()}}Views).called(1);
        verify(() => storage.set{{name.pascalCase()}}Views(current{{name.pascalCase()}}Views - 1))
            .called(1);
      });

      test(
          'throws a Decrement{{name.pascalCase()}}ViewsFailure '
          'when decrementing article views fails', () async {
        when(() => storage.set{{name.pascalCase()}}Views(any())).thenThrow(Exception());

        expect(
          () => {name.camelCase()}Repository.decrement{{name.pascalCase()}}Views(),
          throwsA(isA<Decrement{{name.pascalCase()}}ViewsFailure>()),
        );
      });
    });

    group('reset{{name.pascalCase()}}Views', () {
      test(
          'calls {{name.pascalCase()}}Storage.set{{name.pascalCase()}}Views '
          'with 0 article views', () async {
        await {name.camelCase()}Repository.reset{{name.pascalCase()}}Views();
        verify(() => storage.set{{name.pascalCase()}}Views(0)).called(1);
      });

      test(
          'calls {{name.pascalCase()}}Storage.set{{name.pascalCase()}}ViewsResetDate '
          'with current date', () async {
        final now = DateTime(2022, 6, 7);
        await withClock(Clock.fixed(now), () async {
          await {name.camelCase()}Repository.reset{{name.pascalCase()}}Views();
          verify(() => storage.set{{name.pascalCase()}}ViewsResetDate(now)).called(1);
        });
      });

      test(
          'throws a Reset{{name.pascalCase()}}ViewsFailure '
          'when resetting article views fails', () async {
        when(() => storage.set{{name.pascalCase()}}Views(any())).thenThrow(Exception());

        expect(
          () => {name.camelCase()}Repository.reset{{name.pascalCase()}}Views(),
          throwsA(isA<Reset{{name.pascalCase()}}ViewsFailure>()),
        );
      });
    });

    group('fetch{{name.pascalCase()}}Views', () {
      test(
          'returns the number of article views '
          'from {{name.pascalCase()}}Storage.fetch{{name.pascalCase()}}Views', () async {
        const current{{name.pascalCase()}}Views = 3;
        when(storage.fetch{{name.pascalCase()}}Views)
            .thenAnswer((_) async => current{{name.pascalCase()}}Views);
        when(storage.fetch{{name.pascalCase()}}ViewsResetDate).thenAnswer((_) async => null);
        final result = await {name.camelCase()}Repository.fetch{{name.pascalCase()}}Views();
        expect(result.views, equals(current{{name.pascalCase()}}Views));
      });

      test(
          'returns the reset date of the number of article views '
          'from {{name.pascalCase()}}Storage.fetch{{name.pascalCase()}}ViewsResetDate', () async {
        final resetDate = DateTime(2022, 6, 7);
        when(storage.fetch{{name.pascalCase()}}Views).thenAnswer((_) async => 0);
        when(storage.fetch{{name.pascalCase()}}ViewsResetDate)
            .thenAnswer((_) async => resetDate);
        final result = await {name.camelCase()}Repository.fetch{{name.pascalCase()}}Views();
        expect(result.resetAt, equals(resetDate));
      });

      test(
          'throws a Fetch{{name.pascalCase()}}ViewsFailure '
          'when fetching article views fails', () async {
        when(storage.fetch{{name.pascalCase()}}Views).thenThrow(Exception());

        expect(
          () => {name.camelCase()}Repository.fetch{{name.pascalCase()}}Views(),
          throwsA(isA<Fetch{{name.pascalCase()}}ViewsFailure>()),
        );
      });
    });

    group('{{name.pascalCase()}}Failure', () {
      final error = Exception('errorMessage');

      group('Get{{name.pascalCase()}}Failure', () {
        test('has correct props', () {
          expect(Get{{name.pascalCase()}}Failure(error).props, [error]);
        });
      });

      group('GetRelated{{name.pascalCase()}}sFailure', () {
        test('has correct props', () {
          expect(GetRelated{{name.pascalCase()}}sFailure(error).props, [error]);
        });
      });

      group('Increment{{name.pascalCase()}}ViewsFailure', () {
        test('has correct props', () {
          expect(Increment{{name.pascalCase()}}ViewsFailure(error).props, [error]);
        });
      });

      group('Decrement{{name.pascalCase()}}ViewsFailure', () {
        test('has correct props', () {
          expect(Decrement{{name.pascalCase()}}ViewsFailure(error).props, [error]);
        });
      });

      group('Reset{{name.pascalCase()}}ViewsFailure', () {
        test('has correct props', () {
          expect(Reset{{name.pascalCase()}}ViewsFailure(error).props, [error]);
        });
      });

      group('Fetch{{name.pascalCase()}}ViewsFailure', () {
        test('has correct props', () {
          expect(Fetch{{name.pascalCase()}}ViewsFailure(error).props, [error]);
        });
      });
    });

    group('incrementTotal{{name.pascalCase()}}Views', () {
      test(
          'calls UserStorage.setTotal{{name.pascalCase()}}Views '
          'with current total article views increased by 1', () async {
        const total{{name.pascalCase()}}Views = 3;
        when(storage.fetchTotal{{name.pascalCase()}}Views)
            .thenAnswer((_) async => total{{name.pascalCase()}}Views);
        when(() => storage.setTotal{{name.pascalCase()}}Views(any()))
            .thenAnswer((_) async {});

        await {name.camelCase()}Repository.incrementTotal{{name.pascalCase()}}Views();

        verify(storage.fetchTotal{{name.pascalCase()}}Views).called(1);
        verify(
          () => storage.setTotal{{name.pascalCase()}}Views(total{{name.pascalCase()}}Views + 1),
        ).called(1);
      });

      test(
          'throws an IncrementTotal{{name.pascalCase()}}ViewsFailure '
          'when incrementing total article views fails', () async {
        when(() => storage.setTotal{{name.pascalCase()}}Views(any())).thenThrow(Exception());

        expect(
          () => {name.camelCase()}Repository.incrementTotal{{name.pascalCase()}}Views(),
          throwsA(isA<IncrementTotal{{name.pascalCase()}}ViewsFailure>()),
        );
      });
    });

    group('fetchTotal{{name.pascalCase()}}Views', () {
      test(
          'returns the number of total article views '
          'from UserStorage.fetchTotal{{name.pascalCase()}}Views', () async {
        const current{{name.pascalCase()}}Views = 3;
        when(storage.fetchTotal{{name.pascalCase()}}Views)
            .thenAnswer((_) async => current{{name.pascalCase()}}Views);
        final result = await {name.camelCase()}Repository.fetchTotal{{name.pascalCase()}}Views();
        expect(result, equals(current{{name.pascalCase()}}Views));
      });

      test(
          'throws a FetchTotal{{name.pascalCase()}}ViewsFailure '
          'when fetching total article views fails', () async {
        when(storage.fetchTotal{{name.pascalCase()}}Views).thenThrow(Exception());

        expect(
          () => {name.camelCase()}Repository.fetchTotal{{name.pascalCase()}}Views(),
          throwsA(isA<FetchTotal{{name.pascalCase()}}ViewsFailure>()),
        );
      });
    });
  });
}

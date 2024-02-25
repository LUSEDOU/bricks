import 'package:{name.snakeCase()}_repository/{name.snakeCase()}_repository.dart';
import 'package:clock/clock.dart';
import 'package:flutter_news_example_api/client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockFlutterNewsExampleApiClient extends Mock
    implements FlutterNewsExampleApiClient {}

class MockArticleStorage extends Mock implements ArticleStorage {}

void main() {
  group('{name.pascalCase()}Repository', () {
    late FlutterNewsExampleApiClient apiClient;
    late ArticleStorage storage;
    late {name.pascalCase()}Repository {name.camelCase()}Repository;

    setUp(() {
      apiClient = MockFlutterNewsExampleApiClient();
      storage = MockArticleStorage();
      when(() => storage.setArticleViews(any())).thenAnswer((_) async {});
      when(() => storage.setArticleViewsResetDate(any()))
          .thenAnswer((_) async {});

      {name.camelCase()}Repository = {name.pascalCase()}Repository(
        apiClient: apiClient,
        storage: storage,
      );
    });

    group('getArticle', () {
      test(
          'returns ArticleResponse '
          'from ApiClient.getArticle', () {
        const content = <NewsBlock>[
          TextCaptionBlock(text: 'text', color: TextCaptionColor.normal),
          TextParagraphBlock(text: 'text'),
        ];

        final articleResponse = ArticleResponse(
          title: 'title',
          content: content,
          totalCount: content.length,
          url: Uri.parse('https://www.dglobe.com/'),
          isPremium: false,
          isPreview: false,
        );

        when(
          () => apiClient.getArticle(
            id: any(named: 'id'),
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
            preview: any(named: 'preview'),
          ),
        ).thenAnswer((_) async => articleResponse);

        expect(
          {name.camelCase()}Repository.getArticle(
            id: 'id',
            offset: 10,
            limit: 20,
          ),
          completion(equals(articleResponse)),
        );

        verify(
          () => apiClient.getArticle(
            id: 'id',
            offset: 10,
            limit: 20,
          ),
        ).called(1);
      });

      test(
          'throws GetArticleFailure '
          'if ApiClient.getArticle fails', () async {
        when(
          () => apiClient.getArticle(
            id: any(named: 'id'),
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenThrow(Exception);

        expect(
          () => {name.camelCase()}Repository.getArticle(id: 'id'),
          throwsA(isA<GetArticleFailure>()),
        );
      });
    });

    group('getRelatedArticles', () {
      test(
          'returns RelatedArticlesResponse '
          'from ApiClient.getRelatedArticles', () async {
        const relatedArticlesResponse = RelatedArticlesResponse(
          relatedArticles: [
            SpacerBlock(spacing: Spacing.extraLarge),
            DividerHorizontalBlock(),
          ],
          totalCount: 2,
        );

        when(
          () => apiClient.getRelatedArticles(
            id: any(named: 'id'),
          ),
        ).thenAnswer((_) async => relatedArticlesResponse);

        final response = await {name.camelCase()}Repository.getRelatedArticles(id: 'id');

        expect(response, equals(relatedArticlesResponse));
      });

      test(
          'throws GetRelatedArticlesFailure '
          'if ApiClient.getRelatedArticles fails', () async {
        when(
          () => apiClient.getRelatedArticles(
            id: any(named: 'id'),
          ),
        ).thenThrow(Exception());

        expect(
          {name.camelCase()}Repository.getRelatedArticles(id: 'id'),
          throwsA(isA<GetRelatedArticlesFailure>()),
        );
      });
    });

    group('incrementArticleViews', () {
      test(
          'calls ArticleStorage.setArticleViews '
          'with current article views increased by 1', () async {
        const currentArticleViews = 3;
        when(storage.fetchArticleViews)
            .thenAnswer((_) async => currentArticleViews);

        await {name.camelCase()}Repository.incrementArticleViews();

        verify(storage.fetchArticleViews).called(1);
        verify(() => storage.setArticleViews(currentArticleViews + 1))
            .called(1);
      });

      test(
          'throws an IncrementArticleViewsFailure '
          'when incrementing article views fails', () async {
        when(() => storage.setArticleViews(any())).thenThrow(Exception());

        expect(
          () => {name.camelCase()}Repository.incrementArticleViews(),
          throwsA(isA<IncrementArticleViewsFailure>()),
        );
      });
    });

    group('decrementArticleViews', () {
      test(
          'calls ArticleStorage.setArticleViews '
          'with current article views decreased by 1', () async {
        const currentArticleViews = 3;
        when(storage.fetchArticleViews)
            .thenAnswer((_) async => currentArticleViews);

        await {name.camelCase()}Repository.decrementArticleViews();

        verify(storage.fetchArticleViews).called(1);
        verify(() => storage.setArticleViews(currentArticleViews - 1))
            .called(1);
      });

      test(
          'throws a DecrementArticleViewsFailure '
          'when decrementing article views fails', () async {
        when(() => storage.setArticleViews(any())).thenThrow(Exception());

        expect(
          () => {name.camelCase()}Repository.decrementArticleViews(),
          throwsA(isA<DecrementArticleViewsFailure>()),
        );
      });
    });

    group('resetArticleViews', () {
      test(
          'calls ArticleStorage.setArticleViews '
          'with 0 article views', () async {
        await {name.camelCase()}Repository.resetArticleViews();
        verify(() => storage.setArticleViews(0)).called(1);
      });

      test(
          'calls ArticleStorage.setArticleViewsResetDate '
          'with current date', () async {
        final now = DateTime(2022, 6, 7);
        await withClock(Clock.fixed(now), () async {
          await {name.camelCase()}Repository.resetArticleViews();
          verify(() => storage.setArticleViewsResetDate(now)).called(1);
        });
      });

      test(
          'throws a ResetArticleViewsFailure '
          'when resetting article views fails', () async {
        when(() => storage.setArticleViews(any())).thenThrow(Exception());

        expect(
          () => {name.camelCase()}Repository.resetArticleViews(),
          throwsA(isA<ResetArticleViewsFailure>()),
        );
      });
    });

    group('fetchArticleViews', () {
      test(
          'returns the number of article views '
          'from ArticleStorage.fetchArticleViews', () async {
        const currentArticleViews = 3;
        when(storage.fetchArticleViews)
            .thenAnswer((_) async => currentArticleViews);
        when(storage.fetchArticleViewsResetDate).thenAnswer((_) async => null);
        final result = await {name.camelCase()}Repository.fetchArticleViews();
        expect(result.views, equals(currentArticleViews));
      });

      test(
          'returns the reset date of the number of article views '
          'from ArticleStorage.fetchArticleViewsResetDate', () async {
        final resetDate = DateTime(2022, 6, 7);
        when(storage.fetchArticleViews).thenAnswer((_) async => 0);
        when(storage.fetchArticleViewsResetDate)
            .thenAnswer((_) async => resetDate);
        final result = await {name.camelCase()}Repository.fetchArticleViews();
        expect(result.resetAt, equals(resetDate));
      });

      test(
          'throws a FetchArticleViewsFailure '
          'when fetching article views fails', () async {
        when(storage.fetchArticleViews).thenThrow(Exception());

        expect(
          () => {name.camelCase()}Repository.fetchArticleViews(),
          throwsA(isA<FetchArticleViewsFailure>()),
        );
      });
    });

    group('ArticleFailure', () {
      final error = Exception('errorMessage');

      group('GetArticleFailure', () {
        test('has correct props', () {
          expect(GetArticleFailure(error).props, [error]);
        });
      });

      group('GetRelatedArticlesFailure', () {
        test('has correct props', () {
          expect(GetRelatedArticlesFailure(error).props, [error]);
        });
      });

      group('IncrementArticleViewsFailure', () {
        test('has correct props', () {
          expect(IncrementArticleViewsFailure(error).props, [error]);
        });
      });

      group('DecrementArticleViewsFailure', () {
        test('has correct props', () {
          expect(DecrementArticleViewsFailure(error).props, [error]);
        });
      });

      group('ResetArticleViewsFailure', () {
        test('has correct props', () {
          expect(ResetArticleViewsFailure(error).props, [error]);
        });
      });

      group('FetchArticleViewsFailure', () {
        test('has correct props', () {
          expect(FetchArticleViewsFailure(error).props, [error]);
        });
      });
    });

    group('incrementTotalArticleViews', () {
      test(
          'calls UserStorage.setTotalArticleViews '
          'with current total article views increased by 1', () async {
        const totalArticleViews = 3;
        when(storage.fetchTotalArticleViews)
            .thenAnswer((_) async => totalArticleViews);
        when(() => storage.setTotalArticleViews(any()))
            .thenAnswer((_) async {});

        await {name.camelCase()}Repository.incrementTotalArticleViews();

        verify(storage.fetchTotalArticleViews).called(1);
        verify(
          () => storage.setTotalArticleViews(totalArticleViews + 1),
        ).called(1);
      });

      test(
          'throws an IncrementTotalArticleViewsFailure '
          'when incrementing total article views fails', () async {
        when(() => storage.setTotalArticleViews(any())).thenThrow(Exception());

        expect(
          () => {name.camelCase()}Repository.incrementTotalArticleViews(),
          throwsA(isA<IncrementTotalArticleViewsFailure>()),
        );
      });
    });

    group('fetchTotalArticleViews', () {
      test(
          'returns the number of total article views '
          'from UserStorage.fetchTotalArticleViews', () async {
        const currentArticleViews = 3;
        when(storage.fetchTotalArticleViews)
            .thenAnswer((_) async => currentArticleViews);
        final result = await {name.camelCase()}Repository.fetchTotalArticleViews();
        expect(result, equals(currentArticleViews));
      });

      test(
          'throws a FetchTotalArticleViewsFailure '
          'when fetching total article views fails', () async {
        when(storage.fetchTotalArticleViews).thenThrow(Exception());

        expect(
          () => {name.camelCase()}Repository.fetchTotalArticleViews(),
          throwsA(isA<FetchTotalArticleViewsFailure>()),
        );
      });
    });
  });
}

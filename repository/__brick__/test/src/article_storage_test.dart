import 'package:{name.snakeCase()}_repository/{name.snakeCase()}_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:storage/storage.dart';
import 'package:test/test.dart';

class MockStorage extends Mock implements Storage {}

void main() {
  group('{{name.pascalCase()}}Storage', () {
    late Storage storage;

    setUp(() {
      storage = MockStorage();

      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});
    });

    group('set{{name.pascalCase()}}Views', () {
      test('saves the value in Storage', () async {
        const views = 3;

        await {{name.pascalCase()}}Storage(storage: storage).set{{name.pascalCase()}}Views(views);

        verify(
          () => storage.write(
            key: {{name.pascalCase()}}StorageKeys.articleViews,
            value: views.toString(),
          ),
        ).called(1);
      });
    });

    group('fetch{{name.pascalCase()}}Views', () {
      test('returns the value from Storage', () async {
        when(
          () => storage.read(key: {{name.pascalCase()}}StorageKeys.articleViews),
        ).thenAnswer((_) async => '3');

        final result =
            await {{name.pascalCase()}}Storage(storage: storage).fetch{{name.pascalCase()}}Views();

        verify(
          () => storage.read(
            key: {{name.pascalCase()}}StorageKeys.articleViews,
          ),
        ).called(1);

        expect(result, equals(3));
      });

      test('returns 0 when no value exists in Storage', () async {
        when(
          () => storage.read(key: {{name.pascalCase()}}StorageKeys.articleViews),
        ).thenAnswer((_) async => null);

        final result =
            await {{name.pascalCase()}}Storage(storage: storage).fetch{{name.pascalCase()}}Views();

        verify(
          () => storage.read(
            key: {{name.pascalCase()}}StorageKeys.articleViews,
          ),
        ).called(1);

        expect(result, isZero);
      });
    });

    group('set{{name.pascalCase()}}ViewsResetDate', () {
      test('saves the value in Storage', () async {
        final date = DateTime(2022, 6, 7);

        await {{name.pascalCase()}}Storage(storage: storage).set{{name.pascalCase()}}ViewsResetDate(date);

        verify(
          () => storage.write(
            key: {{name.pascalCase()}}StorageKeys.articleViewsResetAt,
            value: date.toIso8601String(),
          ),
        ).called(1);
      });
    });

    group('fetch{{name.pascalCase()}}ViewsResetDate', () {
      test('returns the value from Storage', () async {
        final date = DateTime(2022, 6, 7);

        when(
          () => storage.read(key: {{name.pascalCase()}}StorageKeys.articleViewsResetAt),
        ).thenAnswer((_) async => date.toIso8601String());

        final result =
            await {{name.pascalCase()}}Storage(storage: storage).fetch{{name.pascalCase()}}ViewsResetDate();

        verify(
          () => storage.read(
            key: {{name.pascalCase()}}StorageKeys.articleViewsResetAt,
          ),
        ).called(1);

        expect(result, equals(date));
      });

      test('returns null when no value exists in Storage', () async {
        when(
          () => storage.read(key: {{name.pascalCase()}}StorageKeys.articleViewsResetAt),
        ).thenAnswer((_) async => null);

        final result =
            await {{name.pascalCase()}}Storage(storage: storage).fetch{{name.pascalCase()}}ViewsResetDate();

        verify(
          () => storage.read(
            key: {{name.pascalCase()}}StorageKeys.articleViewsResetAt,
          ),
        ).called(1);

        expect(result, isNull);
      });
    });

    group('setTotal{{name.pascalCase()}}Views', () {
      test('saves the value in Storage', () async {
        const views = 3;

        await {{name.pascalCase()}}Storage(storage: storage).setTotal{{name.pascalCase()}}Views(views);

        verify(
          () => storage.write(
            key: {{name.pascalCase()}}StorageKeys.total{{name.pascalCase()}}Views,
            value: views.toString(),
          ),
        ).called(1);
      });
    });

    group('fetchTotal{{name.pascalCase()}}Views', () {
      test('returns the value from Storage', () async {
        when(
          () => storage.read(key: {{name.pascalCase()}}StorageKeys.total{{name.pascalCase()}}Views),
        ).thenAnswer((_) async => '3');

        final result =
            await {{name.pascalCase()}}Storage(storage: storage).fetchTotal{{name.pascalCase()}}Views();

        verify(
          () => storage.read(
            key: {{name.pascalCase()}}StorageKeys.total{{name.pascalCase()}}Views,
          ),
        ).called(1);

        expect(result, equals(3));
      });

      test('returns 0 when no value exists in Storage', () async {
        when(
          () => storage.read(key: {{name.pascalCase()}}StorageKeys.total{{name.pascalCase()}}Views),
        ).thenAnswer((_) async => null);

        final result =
            await {{name.pascalCase()}}Storage(storage: storage).fetchTotal{{name.pascalCase()}}Views();

        verify(
          () => storage.read(
            key: {{name.pascalCase()}}StorageKeys.total{{name.pascalCase()}}Views,
          ),
        ).called(1);

        expect(result, isZero);
      });

      test('returns 0 when stored value is malformed', () async {
        when(
          () => storage.read(key: {{name.pascalCase()}}StorageKeys.total{{name.pascalCase()}}Views),
        ).thenAnswer((_) async => 'malformed');

        final result =
            await {{name.pascalCase()}}Storage(storage: storage).fetchTotal{{name.pascalCase()}}Views();

        verify(
          () => storage.read(
            key: {{name.pascalCase()}}StorageKeys.total{{name.pascalCase()}}Views,
          ),
        ).called(1);

        expect(result, isZero);
      });
    });
  });
}

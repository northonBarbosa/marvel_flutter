import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_marvel/src/errors/app_errors.dart';
import 'package:flutter_marvel/src/model/character_comics_response_model.dart';
import 'package:flutter_marvel/src/repositories/comics_api_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dio_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  dotenv.testLoad(fileInput: File('.env').readAsStringSync());

  group('Comics Api Repository', () {
    late ComicsApiRepository repository;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      repository = ComicsApiRepository();
      repository.dio = mockDio;
    });

    test('Success case! Needs to return a CharacterComicsResponseModel object.', () async {
      when(mockDio.get(any)).thenAnswer(
        (_) => Future.value(
          Response(
            requestOptions: RequestOptions(),
            data: {
              "data": {
                "offset": 0,
                "limit": 20,
                "total": 911,
                "count": 20,
                "results": [
                  {
                    "id": 107621,
                    "title": "Uncanny Avengers (2023) #3",
                    "thumbnail": {
                      "path": "http://i.annihil.us/u/prod/marvel/i/mg/b/e0/64c7d3af1fb02",
                      "extension": "jpg"
                    },
                  }
                ]
              }
            },
            statusCode: 200,
          ),
        ),
      );

      final result = await repository.fetchCharacterComics(0, 0);

      expect(result, isA<Right<AppError, CharacterComicsResponseModel>>());
    });

    test('Failure case! This is a Dio Exception case, needs to return a AppError object', () async {
      when(mockDio.get(any)).thenThrow(
        DioException(
          requestOptions: RequestOptions(),
          response: Response(
            requestOptions: RequestOptions(),
            data: {'message': 'Error'},
            statusCode: 500,
          ),
        ),
      );

      final result = await repository.fetchCharacterComics(0, 0);

      expect(result, isA<Left<AppError, CharacterComicsResponseModel>>());
    });

    test('Failure case! This is a Exception case, needs to return a AppError object', () async {
      when(mockDio.get(any)).thenThrow(Exception('Some error'));

      final result = await repository.fetchCharacterComics(0, 0);

      expect(result, isA<Left<AppError, CharacterComicsResponseModel>>());
    });
  });
}

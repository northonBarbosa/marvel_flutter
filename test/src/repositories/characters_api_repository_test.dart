import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_marvel/src/errors/app_errors.dart';
import 'package:flutter_marvel/src/model/characters_response_model.dart';
import 'package:flutter_marvel/src/repositories/characters_api_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dio_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  dotenv.testLoad(fileInput: File('.env').readAsStringSync());

  group('Characters Api Repository', () {
    late CharactersApiRepository repository;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      repository = CharactersApiRepository();
      repository.dio = mockDio;
    });

    test('Success case! Needs to return a CharactersResponseModel object.', () async {
      when(mockDio.get(any)).thenAnswer(
        (_) => Future.value(
          Response(
            requestOptions: RequestOptions(),
            data: {
              "data": {
                "offset": 0,
                "limit": 20,
                "total": 1,
                "count": 1,
                "results": [
                  {
                    "id": 1009268,
                    "name": "Deadpool",
                    "description": "",
                    "modified": "2020-04-04T19:02:15-0400",
                    "thumbnail": {
                      "path": "http://i.annihil.us/u/prod/marvel/i/mg/9/90/5261a86cacb99",
                      "extension": "jpg",
                    },
                    "resourceURI": "http://gateway.marvel.com/v1/public/characters/1009268",
                  }
                ]
              }
            },
            statusCode: 200,
          ),
        ),
      );

      final result = await repository.fetchCharacters(0);

      expect(result, isA<Right<AppError, CharactersResponseModel>>());
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

      final result = await repository.fetchCharacters(0);

      expect(result, isA<Left<AppError, CharactersResponseModel>>());
    });

    test('Failure case! This is a Exception case, needs to return a AppError object', () async {
      when(mockDio.get(any)).thenThrow(Exception('Some error'));

      final result = await repository.fetchCharacters(0);

      expect(result, isA<Left<AppError, CharactersResponseModel>>());
    });
  });
}

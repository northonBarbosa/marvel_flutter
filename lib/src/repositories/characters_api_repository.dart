import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_marvel/src/core/api/api.dart';
import 'package:flutter_marvel/src/errors/app_errors.dart';
import 'package:flutter_marvel/src/model/characters_response_model.dart';

class CharactersApiRepository {
  Dio dio = Dio(kBaseClientOptions);

  Future<Either<AppError, CharactersResponseModel>> fetchCharacters(int offset) async {
    try {
      final response = await dio.get('/characters?offset=$offset');
      final model = CharactersResponseModel.fromJson(response.data['data']);

      return Right(model);
    } on DioException catch (error) {
      return Left(
        AppApiRepositoryError(
            error.response?.data['message'] ?? error.message, 'CharactersApiRepository: fetchCharacters'),
      );
    } on Exception catch (error) {
      return Left(
        AppApiRepositoryError(error.toString(), 'CharactersApiRepository: fetchCharacters'),
      );
    }
  }
}

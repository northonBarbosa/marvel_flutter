import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_marvel/src/core/api/api.dart';
import 'package:flutter_marvel/src/errors/app_errors.dart';
import 'package:flutter_marvel/src/model/character_comics_response_model.dart';

class ComicsApiRepository {
  Dio dio = Dio(kBaseClientOptions);

  Future<Either<AppError, CharacterComicsResponseModel>> fetchCharacterComics(int id, int offset) async {
    try {
      final response = await dio.get('/characters/$id/comics?offset=$offset&orderBy=-onsaleDate');
      final model = CharacterComicsResponseModel.fromJson(id, response.data['data']);

      return Right(model);
    } on DioException catch (error) {
      return Left(AppApiRepositoryError(
          error.response?.data['message'] ?? error.message, 'ComicssApiRepository: fetchCharacterComics'));
    } on Exception catch (error) {
      return Left(
        AppApiRepositoryError(error.toString(), 'ComicssApiRepository: fetchCharacterComics'),
      );
    }
  }
}

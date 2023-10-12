import 'package:dartz/dartz.dart';
import 'package:flutter_marvel/src/errors/app_errors.dart';
import 'package:flutter_marvel/src/model/base_controller.dart';
import 'package:flutter_marvel/src/model/character_comics_response_model.dart';
import 'package:flutter_marvel/src/model/comic_model.dart';
import 'package:flutter_marvel/src/repositories/comics_api_repository.dart';
import 'package:get/state_manager.dart';

class ComicsController implements BaseController {
  static final ComicsController _controller = ComicsController._internal();
  final ComicsApiRepository _repository = ComicsApiRepository();

  factory ComicsController() {
    return _controller;
  }

  ComicsController._internal();

  AppError? appError;

  int _totalComicsCount = 0;
  int _currentCharacterId = 0;

  final RxList<ComicModel> _comicsList = <ComicModel>[].obs;

  int get totalComicsCount => _totalComicsCount;
  int get currentCharacterId => _currentCharacterId;

  @override
  bool get hasMore => itemsList.length < totalComicsCount;

  @override
  RxList<ComicModel> get itemsList => _comicsList;

  @override
  Future<Either<AppError, CharacterComicsResponseModel>> fetchItems({int? id}) async {
    final result = await _repository.fetchCharacterComics(id!, _comicsList.length);
    result.fold(
      (error) => appError = error,
      (comics) {
        _currentCharacterId = comics.characterId;
        _totalComicsCount = comics.totalCount;
        _comicsList.addAll(comics.comics);
      },
    );

    return result;
  }

  void clearCharacterComics() {
    _currentCharacterId = 0;
    _comicsList.clear();
  }
}

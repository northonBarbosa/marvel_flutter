import 'package:dartz/dartz.dart';
import 'package:flutter_marvel/src/errors/app_errors.dart';
import 'package:flutter_marvel/src/model/base_controller.dart';
import 'package:flutter_marvel/src/model/character_model.dart';
import 'package:flutter_marvel/src/model/characters_response_model.dart';
import 'package:flutter_marvel/src/repositories/characters_api_repository.dart';
import 'package:get/state_manager.dart';

class CharactersController implements BaseController {
  static final CharactersController _controller = CharactersController._internal();
  final CharactersApiRepository _repository = CharactersApiRepository();

  factory CharactersController() {
    return _controller;
  }

  CharactersController._internal();

  AppError? appError;

  int _totalCharacterCount = 0;

  final RxList<CharacterModel> _charactersList = <CharacterModel>[].obs;

  int get totalCharacterCount => _totalCharacterCount;

  @override
  bool get hasMore => itemsList.length < totalCharacterCount;

  @override
  RxList<CharacterModel> get itemsList => _charactersList;

  @override
  Future<Either<AppError, CharactersResponseModel>> fetchItems({int? id}) async {
    final result = await _repository.fetchCharacters(itemsList.length);
    result.fold(
      (error) => appError = error,
      (characters) {
        _totalCharacterCount = characters.totalCount;
        _charactersList.addAll(characters.characters);
      },
    );

    return result;
  }
}

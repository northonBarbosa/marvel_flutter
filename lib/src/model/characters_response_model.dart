import 'package:flutter_marvel/src/model/character_model.dart';

class CharactersResponseModel {
  late int offset;
  late int count;
  late int totalCount;
  late final List<CharacterModel> characters;

  CharactersResponseModel({
    required this.offset,
    required this.count,
    required this.totalCount,
    required this.characters,
  });

  CharactersResponseModel.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    count = json['count'];
    totalCount = json['total'];
    characters = List<CharacterModel>.from(json["results"].map(
      (character) => CharacterModel.fromJson(character),
    ));
  }
}

import 'package:flutter_marvel/src/model/comic_model.dart';

class CharacterComicsResponseModel {
  late final int offset;
  late final int count;
  late final int totalCount;
  late final int characterId;
  late final List<ComicModel> comics;

  CharacterComicsResponseModel({
    required this.offset,
    required this.count,
    required this.totalCount,
    required this.characterId,
    required this.comics,
  });

  CharacterComicsResponseModel.fromJson(int id, Map<String, dynamic> json) {
    offset = json['offset'];
    count = json['count'];
    totalCount = json['total'];
    characterId = id;
    comics = List<ComicModel>.from(json["results"].map(
      (comic) => ComicModel.fromJson(comic),
    ));
  }
}

import 'package:flutter_marvel/src/model/comic_model.dart';

class CharacterModel {
  late final int id;
  late final String name;
  late final String description;
  late final String thumbnail;
  late final List<ComicModel> comics;

  CharacterModel({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    this.comics = const [],
  });

  CharacterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'] != "" ? json['description'] : "No description for this character";
    thumbnail = "${json['thumbnail']['path']}.${json['thumbnail']['extension']}";
  }
}

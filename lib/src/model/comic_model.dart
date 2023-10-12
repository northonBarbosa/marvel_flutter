class ComicModel {
  late final String title;
  late final String thumbnail;

  ComicModel({required this.title, required this.thumbnail});

  ComicModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumbnail = "${json['thumbnail']['path']}.${json['thumbnail']['extension']}";
  }
}

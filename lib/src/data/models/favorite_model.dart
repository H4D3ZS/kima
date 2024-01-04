
class FavoriteModel {
  String? name;
  String? image;
  String? type;

  FavoriteModel({this.name, this.image, this.type});

  @override
  String toString() {
    return 'FavoriteModel{name: $name, image: $image, type: $type}';
  }

}
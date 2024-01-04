class FavoriteUser {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? profileAvatar;

  FavoriteUser({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.profileAvatar
  });

  factory FavoriteUser.fromJson(Map<String, dynamic> json) => FavoriteUser(
    id: json['id'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    email: json['email'],
    profileAvatar: json['profileAvatar'],
  );
}
class Favorite {
  int? id;
  String? createdAt;
  FavoriteUser? favoriteUser;

  Favorite({
    this.id,
    this.createdAt,
    this.favoriteUser
  });

  // from API
  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    id: json['id'],
    createdAt: json['createdAt'],
    favoriteUser: json['favoriteUser']
  );
}
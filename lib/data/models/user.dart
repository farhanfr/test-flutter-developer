import 'dart:convert';

class FetchUserDataResponse {
  User data;

  FetchUserDataResponse({
    required this.data,
  });

  factory FetchUserDataResponse.fromJson(Map<String, dynamic> json) =>
      FetchUserDataResponse(
        data: User.fromJson(json["data"]),
      );
}

class User {
  int id;
  String iso6391;
  String iso31661;
  String name;
  bool includeAdult;
  String username;

  User({
    required this.id,
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.includeAdult,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        name: json["name"],
        includeAdult: json["include_adult"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "iso_639_1": iso6391,
        "iso_3166_1": iso31661,
        "name": name,
        "include_adult": includeAdult,
        "username": username,
      };
}

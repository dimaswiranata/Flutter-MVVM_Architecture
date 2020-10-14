import 'dart:convert';

List<Album> albumFromJson(String str) =>
  List<Album>.from(json.decode(str).map((x) => Album.fromJson(x)));

String albumToJson(List<Album> data) =>
  json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Album {
  int userId;
  int id;
  String title;

  Album({ 
    this.userId, 
    this.id, 
    this.title 
  });

  factory Album.fromJson(Map<String, dynamic> json) => 
    Album(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
    );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title
  };
}
import 'dart:convert';

UserGetApi userGetApiFromMap(String str) =>
    UserGetApi.fromMap(json.decode(str));

String userGetApiToMap(UserGetApi data) => json.encode(data.toMap());

class UserGetApi {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<Datum> data;
  Support support;

  UserGetApi({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });

  factory UserGetApi.fromMap(Map<String, dynamic> json) => UserGetApi(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        support: Support.fromMap(json["support"]),
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "support": support.toMap(),
      };
}

class Datum {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  Datum({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}

class Support {
  String url;
  String text;

  Support({
    required this.url,
    required this.text,
  });

  factory Support.fromMap(Map<String, dynamic> json) =>
      Support(url: json["url"], text: json["text"]);

  Map<String, dynamic> toMap() => {
        "url": url,
        "text": text,
      };
}
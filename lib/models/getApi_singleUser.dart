import 'dart:convert';

class SingleuserApi {
  Data? data;
  Support? support;

  SingleuserApi({
    this.data,
    this.support,
  });

  factory SingleuserApi.fromMap(Map<String, dynamic> json) => SingleuserApi(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        support:
            json["support"] == null ? null : Support.fromMap(json["support"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "support": support?.toMap(),
      };
}

class Data {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  Data({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"] ?? 0,
        email: json["email"] ?? "",
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        avatar: json["avatar"] ?? "",
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
  String? url;
  String? text;

  Support({
    this.url,
    this.text,
  });

  factory Support.fromMap(Map<String, dynamic> json) => Support(
        url: json["url"],
        text: json["text"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "text": text,
      };
}

// Function to fetch data

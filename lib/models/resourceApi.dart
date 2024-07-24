import 'dart:convert';

class ResourceApiModel {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<ResourceData> data;
  Support support;

  ResourceApiModel({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });

  factory ResourceApiModel.fromMap(Map<String, dynamic> json) => ResourceApiModel(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<ResourceData>.from(json["data"].map((x) => ResourceData.fromMap(x))),
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

class ResourceData {
  int id;
  String name;
  int year;
  String color;
  String pantoneValue;

  ResourceData({
    required this.id,
    required this.name,
    required this.year,
    required this.color,
    required this.pantoneValue,
  });

  factory ResourceData.fromMap(Map<String, dynamic> json) => ResourceData(
        id: json["id"],
        name: json["name"],
        year: json["year"],
        color: json["color"],
        pantoneValue: json["pantone_value"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "year": year,
        "color": color,
        "pantone_value": pantoneValue,
      };
}

class Support {
  String url;
  String text;

  Support({
    required this.url,
    required this.text,
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
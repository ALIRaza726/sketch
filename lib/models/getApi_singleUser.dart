import 'dart:convert';
import 'package:http/http.dart' as http;
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
 Future<SingleuserApi?> fetchUser() async {
  var headers = {
    'Accept': 'application/json',
    'Authorization':
        'Bearer 59387|rVxTQUFzgeptn2NWBgcNxnO4exfHo880AJApBJEI49e733d9',
  };

  var request = http.Request('GET', Uri.parse('https://reqres.in/api/users/2'))
    ..headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);
      return SingleuserApi.fromMap(data);
    } else {
      print('Error: ${response.reasonPhrase}');
      return null;
    }
  } catch (e) {
    print('Exception: $e');
    return null;
  }
 
}
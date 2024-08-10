import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sketch/helpers/PostApi_RegisterProvider.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _message;

 

  @override
  Widget build(BuildContext context) {
    final registeruserProvider = Provider.of<RegisterUserProvider>(context);
     void _register() async {
    setState(() {
      _isLoading = true;
    });

    final response = await registeruserProvider.registerUser(
      _emailController.text,
      _passwordController.text,
    );

    setState(() {
      _isLoading = false;
      if (response != null) {
        _message =
            'Registration successful! ID: ${registeruserProvider.id}, Token: ${registeruserProvider.token}';
            
      } else {
        _message = 'Registration failed!';
      }
    });
  }
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              if (_isLoading) CircularProgressIndicator(),
              if (_message != null) ...[
                SizedBox(height: 20),
                Text(_message!),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _register,
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Function to register a user
// Future<Datum?> registerUser(String email, String password) async {
//   var headers = {
//     'Content-Type': 'application/json',
//   };

//   var request =
//       http.Request('POST', Uri.parse('https://reqres.in/api/register'))
//         ..headers.addAll(headers)
//         ..body = json.encode({
//           'email': email,
//           'password': password,
//         });

//   try {
//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
     
//       String responseBody = await response.stream.bytesToString();
//        print('response: ${responseBody}');
//       final data = json.decode(responseBody);
//       return Datum.fromMap(data);
//     } else {
//       print('Error: ${response.reasonPhrase}');
//       return null;
//     }
//   } catch (e) {
//     print('Exception: $e');
//     return null;
//   }
// }

Registeruser registeruserFromMap(String str) =>
    Registeruser.fromMap(json.decode(str));

String registeruserToMap(Registeruser data) => json.encode(data.toMap());

class Registeruser {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<Datum>? data;
  Support? support;

  Registeruser({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
  });

  factory Registeruser.fromMap(Map<String, dynamic> json) => Registeruser(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
        support:
            json["support"] == null ? null : Support.fromMap(json["support"]),
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "support": support?.toMap(),
      };
}

class Datum {
  int? id;
  String? name;
  int? year;
  String? color;
  String? pantoneValue;
  String? token;

  Datum({
    this.id,
    this.name,
    this.year,
    this.color,
    this.pantoneValue,
    this.token,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        year: json["year"],
        color: json["color"],
        pantoneValue: json["pantone_value"],
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "year": year,
        "color": color,
        "pantone_value": pantoneValue,
        "token": token,
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


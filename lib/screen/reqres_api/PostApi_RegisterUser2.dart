import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class RegisterUser2 extends StatefulWidget {
  const RegisterUser2({super.key});

  @override
  State<RegisterUser2> createState() => _RegisterUser2State();
}

class _RegisterUser2State extends State<RegisterUser2> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _message;

  void _register() async {
    setState(() {
      _isLoading = true;
    });

    final response = await registerUser(
      _emailController.text,
      _passwordController.text,
    );

    setState(() {
      _isLoading = false;
      if (response != null) {
        if (response.token != null) {
          _message =
              'Registration successful! ID: ${response.id}, Token: ${response.token}';
        }
         else {
          _message = 'Registration failed: ${response.error}';
        }
      } 
      else {
        _message = 'Registration failed!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
Future<Datum?> registerUser(String email, String password) async {
  var headers = {
    'Content-Type': 'application/json',
  };

  var request =
      http.Request('POST', Uri.parse('https://reqres.in/api/register'))
        ..headers.addAll(headers)
        ..body = json.encode({
          'email': email,
          'password': password,
        });

  try {
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);
      return Datum.fromMap(data);
    } else {
      String responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);
      return Datum.fromMap(data);
    }
  } catch (e) {
    print('Exception: $e');
    return null;
  }
}
// Model class

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
  String? error;

  Datum({
    this.id,
    this.name,
    this.year,
    this.color,
    this.pantoneValue,
    this.token,
    this.error,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        year: json["year"],
        color: json["color"],
        pantoneValue: json["pantone_value"],
        token: json["token"],
        error: json["error"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "year": year,
        "color": color,
        "pantone_value": pantoneValue,
        "token": token,
        "error": error,
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


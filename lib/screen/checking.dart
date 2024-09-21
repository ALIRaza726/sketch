import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// To parse this JSON data, do
//
//     final getUser = getUserFromJson(jsonString);

import 'dart:convert';

GetUser getUserFromJson(String str) => GetUser.fromJson(json.decode(str));

String getUserToJson(GetUser data) => json.encode(data.toJson());

class GetUser {
    String? fName;
    String? lName;
    String? username;
    String? email;
    String? password;

    GetUser({
        this.fName,
        this.lName,
        this.username,
        this.email,
        this.password,
    });

    factory GetUser.fromJson(Map<String, dynamic> json) => GetUser(
        fName: json["f_name"]??"",
        lName: json["l_name"]??"",
        username: json["username"]??"",
        email: json["email"]??"",
        password: json["password"]??0,
    );

    Map<String, dynamic> toJson() => {
        "f_name": fName,
        "l_name": lName,
        "username": username,
        "email": email,
        "password": password,
    };
}


class UserName extends StatefulWidget {
  const UserName({super.key});

  @override
  State<UserName> createState() => _UserNameState();
}
List<GetUser> _username = [];
class _UserNameState extends State<UserName> {
  
  @override
  void initState() {
    super.initState();
    fetchPosts();
  }
  Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse('https://test.theposgeniee.com/api/register'));
print("nme:${response.statusCode}");
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      setState(() {
        _username = jsonResponse.map((post) => GetUser.fromJson(post)).toList();
        
      });
    } else {
     
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load Name')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
      child: Text("Ali"),
     ),
    );
  }
}
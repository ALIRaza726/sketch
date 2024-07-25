import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sketch/models/getApiLink_model.dart';

class UserDetailScreen extends StatelessWidget {
  final Datum user;

  const UserDetailScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.firstName} ${user.lastName}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.avatar),
              radius: 100,
            ),
            const SizedBox(height: 20),
            Text(
              '${user.firstName} ${user.lastName}',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            Text(user.email, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

// To parse this JSON data, do
//
//     final userGetApi = userGetApiFromMap(jsonString);


Future<UserGetApi> fetchUsers() async {
  final response =
      await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

  if (response.statusCode == 200) {
    return UserGetApi.fromMap(json.decode(response.body));
  } else {
    throw Exception('Failed to load users');
  }
}
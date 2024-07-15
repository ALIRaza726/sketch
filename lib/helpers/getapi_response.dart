import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sketch/models/getApi_model.dart';

Future<UserGetApi> fetchUsers() async {
  final response =
      await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

  if (response.statusCode == 200) {
    return UserGetApi.fromMap(json.decode(response.body));
  } else {
    throw Exception('Failed to load users');
  }
}
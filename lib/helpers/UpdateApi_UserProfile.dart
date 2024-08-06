import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sketch/models/UpdateApi_UserProfile.dart';

class UserDataProvider with ChangeNotifier {
  Data? _user = Data(
    id: 1,
    email: 'janet.weaver@reqres.in',
    firstName: 'Janet12',
    lastName: 'Weaver',
    avatar: 'https://reqres.in/img/faces/4-image.jpg',
  );

  Data? get user => _user;

  Future<void> updateUserData(
      String email, String firstName, String lastName) async {
    final response = await http.put(
      Uri.parse('https://reqres.in/api/users/2'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
      }),
    );

    if (response.statusCode == 200) {
      _user = Data(
        id: _user!.id,
        email: email,
        firstName: firstName,
        lastName: lastName,
        avatar: _user!.avatar,
      );
      notifyListeners();
    } else {
      throw Exception('Failed to update user data');
    }
  }
}

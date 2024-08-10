import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sketch/screen/PostApi_RegisterUser.dart';

class RegisterUserProvider with ChangeNotifier {
  String _token = '';
  String _id = '';
  
 
  

  String get token => _token;
  String get id => _id;
 
 

 // Data? get  Registeruser =>  Registeruser;

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
          // 'token':token,
          // 'id': id,
        });
notifyListeners();
  try {
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     
      String responseBody = await response.stream.bytesToString();
       print('response: ${responseBody}');
      final data = json.decode(responseBody);
      final registerUserApi = Datum.fromMap(data);
      _token = registerUserApi.token??'';
      _id = registerUserApi.id?.toString()??'';
      notifyListeners();
      return registerUserApi;
      
    } else {
      print('Error: ${response.reasonPhrase}');
      return null;
    }
  } catch (e) {
    print('Exception: $e');
    return null;
  }

}

}

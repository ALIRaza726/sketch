import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class actualLogin extends StatefulWidget {
  const actualLogin({super.key});

  @override
  State<actualLogin> createState() => _actualLoginState();
}
  String? _message;
class _actualLoginState extends State<actualLogin> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
 

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    final response = await loginUser(
      _usernameController.text,
      _passwordController.text,
    );

    setState(() {
      _isLoading = false;
      
      if (response != null) {
        if (response.token != null) {
          _message = 'Login successfull Token: ${response.token}';
        } else {
          _message = 'Login failed: ${response.error}';
        }
       } 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
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
                onPressed: _isLoading ? null : _login,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Function to log in a user
Future<LoginSuccessful?> loginUser(String username, String password) async {
  var headers = {
    'Content-Type': 'application/json',
    
  };
  var request = http.Request('POST', Uri.parse('https://test.theposgeniee.com/api/login'))
    ..headers.addAll(headers)
    ..body = json.encode({
      'username': username,
      'password': password,
    });
// print('name:$password');
  try {
    http.StreamedResponse response = await request.send();
    

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);
      print('responselogin: ${responseBody}');
      return LoginSuccessful.fromMap(data);
    }
     else if(response.statusCode == 500)
      {
        _message = 'Username and Password is incorrect'; 
      }
       else if(response.statusCode == 422)
      {
        _message = 'Username Already exist'; 
      }
       else {
      String responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);
      return LoginSuccessful.fromMap(data);
    }
  } catch (e) {
    print('Exception: $e');
    return null;
  }
  return null;
}

class LoginSuccessful {
  String? token;
  String? error;

  LoginSuccessful({
    this.token,
    this.error,
  });

  factory LoginSuccessful.fromMap(Map<String, dynamic> json) => LoginSuccessful(
        token: json["token"],
        error: json["error"],
      );

  Map<String, dynamic> toMap() => {
        "token": token,
        "error": error,
      };

}
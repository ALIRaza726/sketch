import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _message;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _message = null;
      });

      final response = await registerUser(
       firstName: _firstNameController.text,
       lastName:  _lastNameController.text,
       username:   _usernameController.text,
       email:  _emailController.text,
       password:  _passwordController.text,
      );
      

      setState(() {
        _isLoading = false;
        if (response != null && response['success'] == true) {
          _message = 'Registration successful!';
        } else {
          _message = response != null
              ? response['message'] ?? 'Registration failed!'
              : 'Registration failed!';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
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
      ),
    );
  }

  Future<Map<String, dynamic>?> registerUser(
     {required String firstName,
     required String lastName,
     required String username,
     required String email,
     required  String password}) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var request = http.Request('POST', Uri.parse('https://test.theposgeniee.com/api/register'))
      ..headers.addAll(headers)
      ..body = json.encode({
        'f_name': firstName,
        'l_name': lastName,
        'username': username,
        'email': email,
        'password': password,
      });

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        print('Response body: $responseBody');
        return json.decode(responseBody);
      }
       else if(response.statusCode==422)
      {
       String responseBody=await response.stream.bytesToString();
       print('Unprocessable Content: $responseBody');
       return {"sucess": false,"message": "validation failed...please check your inputs"};
      }
      
      else {
        print('Error: ${response.reasonPhrase}');
        return {'success': false, 'message': response.reasonPhrase};
      }
    } 
    catch (e) {
      print('Exception: $e');
      return {'success': false, 'message': e.toString()};
    }
  }
}
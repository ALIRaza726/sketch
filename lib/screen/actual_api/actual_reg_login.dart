import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class RegisterLogin extends StatefulWidget {
  @override
  _RegisterLoginState createState() => _RegisterLoginState();
}


class _RegisterLoginState extends State<RegisterLogin> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fNameController = TextEditingController();
  final _lNameController = TextEditingController();
  final _emailController = TextEditingController();

  Future<void> _registerAndLogin() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final fName = _fNameController.text;
    final lName = _lNameController.text;
    final email = _emailController.text;
    
    

    // Register the user
    final registerResponse = await http.post(
      Uri.parse('https://test.theposgeniee.com/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'f_name': fName,
        'l_name': lName,
        'email': email,
      }),
    );

    final registerResponseData = jsonDecode(registerResponse.body);

    if (registerResponse.statusCode == 201) {
      // Automatically login after successful registration
      final loginResponse = await http.post(
        Uri.parse('https://test.theposgeniee.com/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );
     
   
  

      final loginResponseData = jsonDecode(loginResponse.body);

      if (loginResponse.statusCode == 200) {
        final token = loginResponseData['token'];

        // You can save the token locally if needed
        // For example, using SharedPreferences or a provider

        Navigator.pushReplacementNamed(context, 'home_page');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(loginResponseData['error'] ?? 'Login failed')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(registerResponseData['error'] ?? 'Registration failed')),
      );
    }
    
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            TextField(
              controller: _fNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerAndLogin,
              child: Text('Register & Login'),
            ),
          ],
        ),
      ),
    );
  }
}
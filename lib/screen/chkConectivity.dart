import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class chkConnectivity extends StatefulWidget {
  @override
  _chkConnectivityState createState() => _chkConnectivityState();
}

class _chkConnectivityState extends State<chkConnectivity> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fNameController = TextEditingController();
  final _lNameController = TextEditingController();
  final _emailController = TextEditingController();

  String _errorMessage = '';

  Future<void> _registerAndLogin() async {
    // Check Internet Connectivity
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _errorMessage =
            'No internet connection. Please check your network and try again.';
      });
      return; // Exit if no connectivity
    }

    final username = _usernameController.text;
    final password = _passwordController.text;
    final fName = _fNameController.text;
    final lName = _lNameController.text;
    final email = _emailController.text;

    setState(() {
      _errorMessage = '';
    });

    try {
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

      if (registerResponse.body.isNotEmpty) {
        final registerResponseData = jsonDecode(registerResponse.body);

        // Check the actual condition for a successful registration
        if (registerResponseData['success'] == 'User registered successfully') {
          // Automatically login after successful registration
          final loginResponse = await http.post(
            Uri.parse('https://test.theposgeniee.com/api/login'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'username': username,
              'password': password,
            }),
          );

          if (loginResponse.body.isNotEmpty) {
            final loginResponseData = jsonDecode(loginResponse.body);

            if (loginResponseData.containsKey('token') &&
                loginResponseData['token'] != null) {
              final token = loginResponseData['token'];

              // Save the token locally if needed
              // For example, using SharedPreferences or a provider

              // Navigate to the home screen after successful login
              Navigator.of(context).pushReplacementNamed('/home');
            } else {
              // Handle login failure
              setState(() {
                _errorMessage = loginResponseData['message'] ?? 'Login failed';
              });
            }
          } else {
            setState(() {
              _errorMessage = 'Login response was empty';
            });
          }
        } else {
          // Handle registration failure
          setState(() {
            _errorMessage =
                registerResponseData['error'] ?? 'Registration failed';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Registration response was empty';
        });
      }
    } catch (e) {
      // Handle other errors (e.g., network issues)
      setState(() {
        _errorMessage = 'An error occurred: $e';
      });
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
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
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerAndLogin,
              child: Text('Register and Login'),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Create the HomeScreen widget
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Home Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

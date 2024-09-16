import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthFacebook extends StatefulWidget {
  @override
  _AuthFacebookState createState() => _AuthFacebookState();
}

class _AuthFacebookState extends State<AuthFacebook> {
  bool _isLoading = false;

  // Facebook sign-in method
  Future<void> _signInWithFacebook() async {
    
    try {
      setState(() {
        _isLoading = true;
      });
      print('load:$_isLoading');

      final LoginResult result = await FacebookAuth.instance.login();
      print('result:$result');
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final userData = await FacebookAuth.instance.getUserData();
        
        // Send the Facebook user data to your API for registration
        await _registerUser(
          name: userData['name'] ?? '',
          email: userData['email'] ?? '',
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Facebook login failed')),
        );
      }
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred during login')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Send user data to your API for registration
  Future<void> _registerUser({required String name, required String email}) async {
    final url = Uri.parse('https://test.theposgeniee.com/api/register');
    final response = await http.post(
      url,
      body: {
        'name': name,
        'email': email,
        'password': '123456', // You can change this as needed
        'password_confirmation': '123456',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${data['message']}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register user.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _signInWithFacebook,
                child: Text('Sign in with Facebook'),
              ),
      ),
    );
  }
}
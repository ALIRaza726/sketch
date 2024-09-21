import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketch/helpers/responsive.dart';


class ChkAuthPrefferance extends StatefulWidget {
  @override
  _ChkAuthPrefferanceState createState() => _ChkAuthPrefferanceState();
}

class _ChkAuthPrefferanceState extends State<ChkAuthPrefferance> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // If user is logged in, navigate to HomeScreen
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else {
      // If user is not logged in, navigate to SignupScreen
      Navigator.pushReplacementNamed(context, SignupScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            CircularProgressIndicator(), // Show a loading indicator while checking login status
      ),
    );
  }
}

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup';

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fNameController = TextEditingController();
  final _lNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _registerAndNavigateHome() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final fName = _fNameController.text;
    final lName = _lNameController.text;
    final email = _emailController.text;

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

      final registerResponseData = jsonDecode(registerResponse.body);

      if (registerResponse.statusCode == 201) {
        // If registration is successful, store the user state
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true); // Save login state

        // Navigate to the home screen
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(registerResponseData['error'] ?? 'Registration failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 73, 247, 192),
      body: Column(
        children: [
           Container(
                height: 250,
                width: double.infinity,
                child: const DecoratedBox(
                    position: DecorationPosition.background,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                AssetImage("assets/images/background1.jpg")))),
              ),
               const SizedBox(
                        height: 35,
                      ),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 15 : 30,
                            fontWeight: FontWeight.w900),
                      ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildTextField(
                      controller: _usernameController,
                      label: 'Username',
                      hint: 'Enter your username',
                    ),
                    _buildTextField(
                      controller: _fNameController,
                      label: 'First Name',
                      hint: 'Enter your first name',
                    ),
                    _buildTextField(
                      controller: _lNameController,
                      label: 'Last Name',
                      hint: 'Enter your last name',
                    ),
                    _buildTextField(

                      controller: _emailController,
                      label: 'Email',
                      hint: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    _buildTextField(
                      controller: _passwordController,
                      label: 'Password',
                      hint: 'Enter your password',
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _registerAndNavigateHome();
                        }
                      },
                      child: Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    
    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a $label';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn'); // Clear login state
    Navigator.pushReplacementNamed(context, SignupScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                _logout(context);
              },
            ),
          ],
        ),
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

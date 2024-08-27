// import 'dart:convert';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';


// class preferranceLogin extends StatefulWidget {
//   const preferranceLogin({super.key});

//   @override
//   _preferranceLoginState createState() => _preferranceLoginState();
// }

// class _preferranceLoginState extends State<preferranceLogin> {
//   @override
//   void initState() {
//     super.initState();
//     _checkLoginStatus();
//   }

//   Future<void> _checkLoginStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

//     if (isLoggedIn) {
//       Navigator.pushReplacementNamed(context, 'HomeScreen');
//     } else {
//       Navigator.pushReplacementNamed(context, 'LoginScreen');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }

// class LoginScreen extends StatefulWidget {
//   static const routeName = '/LoginScreen';
//   const LoginScreen({super.key});

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();

//   String _errorMessage = '';

//   Future<void> _login() async {
//     // Check Internet Connectivity
//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.none) {
//       setState(() {
//         _errorMessage =
//             'No internet connection. Please check your network and try again.';
//       });
//       return; // Exit if no connectivity
//     }

//     final username = _usernameController.text;
//     final password = _passwordController.text;

//     setState(() {
//       _errorMessage = '';
//     });

//     try {
//       // Login the user
//       final loginResponse = await http.post(
//         Uri.parse('https://test.theposgeniee.com/api/login'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'username': username,
//           'password': password,
//         }),
//       );

//       if (loginResponse.body.isNotEmpty) {
//         final loginResponseData = jsonDecode(loginResponse.body);

//         if (loginResponseData.containsKey('token') &&
//             loginResponseData['token'] != null) {
//           final token = loginResponseData['token'];

//           // Save login state and token locally
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           await prefs.setBool('isLoggedIn', true);
//           await prefs.setString('token', token);

//           // Navigate to the home screen after successful login
//           Navigator.of(context).pushReplacementNamed('home_page');
//         } else {
//           // Handle login failure
//           setState(() {
//             _errorMessage = loginResponseData['message'] ?? 'Login failed';
//           });
//         }
//       } else {
//         setState(() {
//           _errorMessage = 'Login response was empty';
//         });
//       }
//     } catch (e) {
//       // Handle other errors (e.g., network issues)
//       setState(() {
//         _errorMessage = 'An error occurred: $e';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             TextField(
//               controller: _usernameController,
//               decoration: const InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: const InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _login,
//               child: const Text('Login'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed('RegisterScreen2');
//               },
//               child: const Text("Don't have an account? Register"),
//             ),
//             if (_errorMessage.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   _errorMessage,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RegisterScreen2 extends StatefulWidget {
//   const RegisterScreen2({super.key});

//   @override
//   _RegisterScreen2State createState() => _RegisterScreen2State();
// }

// class _RegisterScreen2State extends State<RegisterScreen2> {
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _fNameController = TextEditingController();
//   final _lNameController = TextEditingController();
//   final _emailController = TextEditingController();

//   String _errorMessage = '';

//   Future<void> _register() async {
//     // Check Internet Connectivity
//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.none) {
//       setState(() {
//         _errorMessage =
//             'No internet connection. Please check your network and try again.';
//       });
//       return; // Exit if no connectivity
//     }

//     final username = _usernameController.text;
//     final password = _passwordController.text;
//     final fName = _fNameController.text;
//     final lName = _lNameController.text;
//     final email = _emailController.text;

//     setState(() {
//       _errorMessage = '';
//     });

//     try {
//       // Register the user
//       final registerResponse = await http.post(
//         Uri.parse('https://test.theposgeniee.com/api/register'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'username': username,
//           'password': password,
//           'f_name': fName,
//           'l_name': lName,
//           'email': email,
//         }),
//       );

//       if (registerResponse.body.isNotEmpty) {
//         final registerResponseData = jsonDecode(registerResponse.body);

//         // Check the actual condition for a successful registration
//         if (registerResponseData['success'] == 'User registered successfully') {
//           Navigator.of(context).pushReplacementNamed('LoginScreen');
//         } else {
//           // Handle registration failure
//           setState(() {
//             _errorMessage =
//                 registerResponseData['error'] ?? 'Registration failed';
//           });
//         }
//       } else {
//         setState(() {
//           _errorMessage = 'Registration response was empty';
//         });
//       }
//     } catch (e) {
//       // Handle other errors (e.g., network issues)
//       setState(() {
//         _errorMessage = 'An error occurred: $e';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Register'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             TextField(
//               controller: _usernameController,
//               decoration: const InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: const InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             TextField(
//               controller: _fNameController,
//               decoration: const InputDecoration(labelText: 'First Name'),
//             ),
//             TextField(
//               controller: _lNameController,
//               decoration: const InputDecoration(labelText: 'Last Name'),
//             ),
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _register,
//               child: const Text('Register'),
//             ),
//             if (_errorMessage.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   _errorMessage,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // HomeScreen with Drawer containing a Logout button
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   Future<void> _logout(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('isLoggedIn');
//     await prefs.remove('token');
//     Navigator.of(context).pushReplacementNamed('LoginScreen');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: <Widget>[
//             const DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: Text('Menu'),
//             ),
//             ListTile(
//               title: const Text('Logout'),
//               onTap: () {
//                 _logout(context);
//               },
//             ),
//           ],
//         ),
//       ),
//       body: const Center(
//         child: Text(
//           'Welcome to the Home Screen!',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }





import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CheckAuthScreen extends StatefulWidget {
  @override
  _CheckAuthScreenState createState() => _CheckAuthScreenState();
}

class _CheckAuthScreenState extends State<CheckAuthScreen> {
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
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
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

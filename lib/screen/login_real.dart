import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketch/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:sketch/screen/home_page.dart';
import 'package:sketch/screen/sign_up.dart';

class CheckAuthLogin extends StatefulWidget {
  @override
  _CheckAuthLoginState createState() => _CheckAuthLoginState();
}

class _CheckAuthLoginState extends State<CheckAuthLogin> {
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
      Navigator.pushReplacementNamed(context, home_page.routeName);
    } else {
      // If user is not logged in, navigate to SignupScreen
      Navigator.pushReplacementNamed(context, LoginReal.routeName);
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

class LoginReal extends StatefulWidget {
  
   static const routeName = '/LoginReal';
  const LoginReal({super.key});
  
static String username='';
 static String userid='';
 
  @override
  State<LoginReal> createState() => LoginRealState();
}
String? _message;
class LoginRealState extends State<LoginReal> {

final _formKey = GlobalKey<FormState>();
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
 if (response != null) {
        if (response.token != null){
            // Save login state

        // Navigate to the home screen
        Navigator.pushReplacementNamed(context, home_page.routeName);
          
          _message = 'Login successfull Token: ${response.token}';
        } else {
          _message = 'Login failed: ${response.error}';
        }
       } 
    setState(() async{
      _isLoading = false;
      
     
    });
  }
 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 73, 247, 192),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Responsive.isMobile(context)
                ? Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 500,
                          height: 250,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 8, 8, 8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const Positioned(
                          top: 35,
                          left: 180,
                          right: 80,
                          child: Image(
                            image: AssetImage('assets/images/key1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Positioned(
                          top: 5,
                          left: 30,
                          right: 260,
                          child: Image(
                            image: AssetImage('assets/images/fingerprint.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Positioned(
                          top: 120,
                          left: 260,
                          right: 5,
                          child: Image(
                            image: AssetImage('assets/images/lock1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Positioned(
                            top: 200,
                            left: 20,
                            bottom: 20,
                            child: Text(
                              'Identify !!!',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red),
                            )),
                        const Positioned(
                            top: 100,
                            left: 360,
                            bottom: 20,
                            child: Text(
                              '? #',
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 245, 239, 63)),
                            ))
                      ],
                    ),
                  )
                : Center(
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 250,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 8, 8, 8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const Positioned(
                          top: 35,
                          left: 550,
                          right: 120,
                          bottom: 50,
                          child: Image(
                            image: AssetImage('assets/images/key1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Positioned(
                          top: 10,
                          left: 320,
                          right: 300,
                          child: Image(
                            image: AssetImage('assets/images/fingerprint.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Positioned(
                          top: 15,
                          left: 20,
                          right: 370,
                          child: Image(
                            image: AssetImage('assets/images/lock1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Positioned(
                            top: 180,
                            left: 20,
                            bottom: 20,
                            child: Text(
                              'Identify !!!',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red),
                            )),
                        const Positioned(
                            top: 100,
                            left: 730,
                            bottom: 20,
                            child: Text(
                              '? #',
                              style: TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 245, 239, 63)),
                            ))
                      ],
                    ),
                  ),
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 15,
                      ),
                    ),
                    const Text(
                      "Login Page",
                      style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 131, 124, 123),
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    const Text(
                      "Already Registered",
                      style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 131, 124, 123),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'User-Name',
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.red)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      // onChanged: (val){
                      //   var userid=val;
                      // },
                     // onFieldSubmitted: (value) {},
                      
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                     SizedBox(height: 20),
              if (_isLoading) CircularProgressIndicator(),
              // if (_message != null) ...[
              //   SizedBox(height: 20),
              //   Text(_message!),
              // ],
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 131, 124, 123)),
                        ),
                        // onPressed: () {
                        //   if (_formKey.currentState!.validate()) {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(
                        //         content: Text('Login Sucessfull'),
                        //       ),
                        //     );
                        //    Navigator.push(
                        //      context,
                        //      MaterialPageRoute(
                        //          builder: (context) => const LoginReal()));
                        //   }
                          
                        // },
                        onPressed: _isLoading ? null : _login,
                        child: const Text(
                          'Login User',
                          style: TextStyle(
                              color: Color.fromARGB(255, 250, 249, 249)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                             onPressed: () {
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => const signup()));
              },
                              child: const Text("Don't have an account? Register"),
            ),
                  ],
                ),
              ),
            ),
          ],
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
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

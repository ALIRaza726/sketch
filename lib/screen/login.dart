import 'package:sketch/helpers/responsive.dart';
import 'package:sketch/screen/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sketch/helpers/responsive.dart';
import 'package:sketch/screen/home_page.dart';

class Login extends StatefulWidget {
  static const routeName = '/Login';
  const Login({super.key});
static String username='';
 static String userid='';
  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  //final TextEditingController _textfieldController = TextEditingController();
  //final TextEditingController _passwordController = TextEditingController();
 
  final _formKey = GlobalKey<FormState>();
  @override
  // void dispose() {
  //   _textfieldController.dispose();
  //   super.dispose();
  // }

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
                      onChanged: (val){
                        var username=val;
                      },
                      onFieldSubmitted: (value) {},
                     // controller: _textfieldController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
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
                      onChanged: (val){
                        var userid=val;
                      },
                      onFieldSubmitted: (value) {},
                      //controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
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
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Login Sucessfull'),
                              ),
                            );
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => const Login()));
                          }
                        },
                        child: const Text(
                          'Add Value',
                          style: TextStyle(
                              color: Color.fromARGB(255, 250, 249, 249)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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

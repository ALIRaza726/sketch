import 'package:flutter/services.dart';
import 'package:sketch/helpers/responsive.dart';
import 'package:sketch/screen/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:sketch/helpers/responsive.dart';
import 'package:sketch/screen/login.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final TextEditingController _textfieldController = TextEditingController();
  final TextEditingController _EmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void Dispose() {
    _textfieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 73, 247, 192),
      body: SingleChildScrollView(
        child: Form(
          key: GlobalKey<FormState>(),
          child: Column(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 15 : 30,
                            fontWeight: FontWeight.w900),
                      ),
                      Row(
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                                fontSize:
                                    Responsive.isMobile(context) ? 10 : 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                             inputFormatters: [
                             FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                              ],
                          controller: _textfieldController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a value';
                            }
                            return null;
                          },
                          cursorHeight: 20,
                          mouseCursor: MaterialStateMouseCursor.textable,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 1),
                                child: Icon(
                                  Icons.edit,
                                  size: Responsive.isMobile(context) ? 10 : 20,
                                  color: Color.fromARGB(255, 3, 1, 24),
                                ),
                              ),
                              hintText: 'Name:',
                              hintStyle: TextStyle(
                                  fontSize:
                                      Responsive.isMobile(context) ? 10 : 20,
                                  color: const Color.fromARGB(255, 20, 2, 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 63, 54, 238))),
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "E_Mail",
                            style: TextStyle(
                                fontSize:
                                    Responsive.isMobile(context) ? 10 : 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          
                          controller: _EmailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a value';
                            }
                            return null;
                          },
                          cursorHeight: 20,
                          mouseCursor: MaterialStateMouseCursor.textable,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              prefixIcon: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 1),
                                child: Icon(
                                  Icons.edit,
                                  size: 10,
                                  color: Color.fromARGB(255, 3, 1, 24),
                                ),
                              ),
                              hintText: 'E_Mail:',
                              hintStyle: TextStyle(
                                  fontSize:
                                      Responsive.isMobile(context) ? 10 : 20,
                                  color: Color.fromARGB(255, 20, 2, 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 63, 54, 238))),
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Password",
                            style: TextStyle(
                                fontSize:
                                    Responsive.isMobile(context) ? 10 : 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                           keyboardType: TextInputType.visiblePassword,
                           // allow all these characters 0-9!@#$%^&*(),.?":{}|<>
                           inputFormatters: [
                            FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9!@#$%^&*(),.?":{}|<>]'))
                ],
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a value';
                            }
                            return null;
                          },
                          cursorHeight: 20,
                          mouseCursor: MaterialStateMouseCursor.textable,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              prefixIcon: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 1),
                                child: Icon(
                                  Icons.edit,
                                  size: 10,
                                  color: Color.fromARGB(255, 3, 1, 24),
                                ),
                              ),
                              hintText: 'Password:',
                              hintStyle: TextStyle(
                                  fontSize:
                                      Responsive.isMobile(context) ? 10 : 20,
                                  color: Color.fromARGB(255, 20, 2, 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 63, 54, 238))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Forget Password ?",
                            style: TextStyle(
                                fontSize:
                                    Responsive.isMobile(context) ? 10 : 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                backgroundColor: const MaterialStatePropertyAll(
                                    Color.fromARGB(255, 125, 180, 164)),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('SignUP Sucessfull'),
                                    ),
                                  );
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Login()));
                                }
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

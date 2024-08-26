import 'package:sketch/screen/app_bar.dart';
import 'package:sketch/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:sketch/screen/sign_up.dart';

class wel_come extends StatefulWidget {
  static const routeName = '/WelcomeScreen';
  const wel_come({super.key});

  @override
  State<wel_come> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<wel_come> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 73, 247, 192),
      body: Column(
        children: [
          const SizedBox(
            height: 250,
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/background1.jpg"),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 40,
                ),
              ),
              const Text(
                "Hello",
                style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 87, 114, 106),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Welcome to My Practice App",
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 87, 114, 106),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                    backgroundColor: const MaterialStatePropertyAll(
                      Colors.black,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, LoginReal.routeName);
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                    backgroundColor: const MaterialStatePropertyAll(
                      Colors.black,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const signup()));
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              const Text(
                "Sign In Using",
                style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 87, 114, 106),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginReal()));
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/facebook.png"),
                            ),
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const wel_come()));
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage("assets/images/google-plus.png"),
                            ),
                            color: Color.fromARGB(255, 251, 252, 253),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const wel_come()));
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/linkedin.png"),
                            ),
                            color: Color.fromARGB(255, 116, 117, 118),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

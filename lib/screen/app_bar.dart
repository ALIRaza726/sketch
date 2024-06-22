import 'package:flutter/material.dart';
import 'package:sketch/helpers/responsive.dart';

class app_bar extends StatefulWidget {
  const app_bar({super.key});

  @override
  State<app_bar> createState() => _app_barState();
}

class _app_barState extends State<app_bar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          //centerTitle: true,
          elevation: 10,
          shadowColor: Color.fromARGB(255, 44, 231, 234),
          backgroundColor: Color.fromARGB(255, 73, 247, 192),

          title: Column(
            children: [
              Row(
                children: [
                  Text(
                    'User Name: ',
                    style: TextStyle(
                      color: Color.fromARGB(255, 1, 1, 17),
                      fontSize: Responsive.isMobile(context) ? 15: 25,
                    ),
                  ),
                  Responsive.isMobile(context)
                      ? const Text(
                          'Ali Raza',
                          style: TextStyle(
                              color: Color.fromARGB(255, 1, 1, 17),
                              fontSize: 15,
                              // fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500),
                        )
                      : const Text(
                          'Ali Raza',
                          style: TextStyle(
                              color: Color.fromARGB(255, 1, 1, 17),
                              fontSize: 25,
                              // fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w900),
                        ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'E-mail: ',
                    style: TextStyle(
                      color: Color.fromARGB(255, 1, 1, 17),
                      fontSize: Responsive.isMobile(context) ? 15 : 25,
                    ),
                  ),
                  Responsive.isMobile(context)
                      ? Text(
                          'Ali@gmail',
                          style: TextStyle(
                              color: Color.fromARGB(255, 1, 1, 17),
                              fontSize:
                                  Responsive.isMobile(context) ? 15 : 25,
                              // fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500),
                        )
                      : Text(
                          'Ali@gmail',
                          style: TextStyle(
                              color: Color.fromARGB(255, 1, 1, 17),
                              fontSize:
                                  Responsive.isMobile(context) ? 15 : 25,
                              // fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w900),
                        ),
                ],
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            // Set the height of the bottom bar
            child: Container(
              color: const Color.fromARGB(255, 63, 214, 225),
              height: 50.0,
              child: Center(
                child: Text(
                  'Bottom of AppBar',
                  style: TextStyle(
                    fontSize: Responsive.isMobile(context) ? 15: 30,
                  ),
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Responsive.isMobile(context)
                          ? Container(
                              width: 130,
                              height: 25,
                              child: TextFormField(
                                cursorColor: Colors.white,
                                cursorHeight: 10,
                                textAlignVertical: TextAlignVertical.center,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10),
                                decoration: InputDecoration(
                                    prefixIcon: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 1),
                                      child: Icon(
                                        Icons.search,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    labelText: 'Search',
                                    labelStyle: const TextStyle(
                                        fontSize: 10, color: Colors.white),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 247, 246, 246))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            )
                          : Container(
                              width: 240,
                              height: 32,
                              child: TextFormField(
                                cursorColor: Colors.white,
                                cursorHeight: 10,
                                textAlignVertical: TextAlignVertical.center,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10),
                                decoration: InputDecoration(
                                    prefixIcon: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 1),
                                      child: Icon(
                                        Icons.search,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    labelText: 'Search',
                                    labelStyle: const TextStyle(
                                        fontSize: 10, color: Colors.white),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 247, 246, 246))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
       
        drawer: Drawer(
          backgroundColor: Color.fromARGB(255, 63, 214, 225),
          width: 200,
          child: ListView(
            children: [
              DrawerHeader(
                curve: Curves.bounceOut,
                duration: const Duration(milliseconds: 500),
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/profile.png'),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Ali Raza',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'User Name: ',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 1, 1, 17),
                            fontSize:
                                Responsive.isMobile(context) ? 15: 20,
                          ),
                        ),
                        Text(
                          'Ali Raza',
                          style: TextStyle(
                              color: Color.fromARGB(255, 1, 1, 17),
                              fontSize:
                                  Responsive.isMobile(context) ? 15 : 20,
                              // fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'E-mail: ',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 1, 1, 17),
                            fontSize:
                                Responsive.isMobile(context) ? 15 : 20,
                          ),
                        ),
                        const Text(
                          'Ali@gmail.com',
                          style: TextStyle(
                              color: Color.fromARGB(255, 1, 1, 17),
                              fontSize: 15,
                              // fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Text(
                          'Password:    ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 1, 1, 17),
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          '*******',
                          style: TextStyle(
                            color: Color.fromARGB(255, 1, 1, 17),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 230, horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            '<< Back ',
                            style: TextStyle(
                                color: Color.fromARGB(255, 1, 1, 17),
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                          width: 60,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const app_bar()));
                      },
                      child: Container(
                        color: Color.fromARGB(255, 51, 171, 180),
                        height: 50,
                        width: 200,
                        margin: EdgeInsets.symmetric(vertical: 70),
                        alignment: Alignment.bottomCenter,
                        child: const Center(
                          child: Text(
                            "goolge Map",
                            style: TextStyle(
                              color: Color.fromARGB(255, 248, 242, 242),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: const Center(child: Text('App Bar Screen',style: TextStyle(
          fontSize: 20
        ),)),
       
    );
  }
}
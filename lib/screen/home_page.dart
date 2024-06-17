import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sketch/helpers/responsive.dart';
import 'package:sketch/screen/app_bar.dart';
import 'package:sketch/screen/date_time.dart';
import 'package:sketch/screen/login.dart';
import 'package:sketch/screen/sign_up.dart';
import 'package:sketch/screen/splashSc_progres.dart';
import 'package:sketch/screen/wel_come.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  final List<String> _yourList = ["Home", "About", "Contact", "Login"];

   Widget _buitlerGridView(int index) {
    var item = _yourList[index];

    return Card(
      elevation: 7,
      color: Color.fromARGB(255, 158, 158, 163),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(child: Text(item)),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 10,
          shadowColor: Colors.green[200],
          backgroundColor: Colors.green[300],
      
          title: Container(),
        ),
         body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15),
                GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Responsive.isMobile(context) ? 4 : 8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  children: [
                    
                   
                    Column(children: [
                     
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/login.png"),
                              ),
                              color: Color.fromARGB(255, 118, 76, 216),
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        
                      ),
                       Text(
                        'Login',
                        style: GoogleFonts.aDLaMDisplay(),
                      ),
                    ]),
                   
                    Column(children: [
                      
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const signup()));
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/sign_up.png'),
                            ),
                          ),
                        ),
                      ),
                      Text('Sign_Up',style: GoogleFonts.aDLaMDisplay(),),
                    ]),
                   Column(children: [
                     
                     GestureDetector(
                       onTap: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => const splashSc_progres()));
                       },
                       child: Container(
                        height: 60,
                          width: 60,
                         decoration: BoxDecoration(
                             image: const DecorationImage(
                               fit: BoxFit.cover,
                               image: AssetImage("assets/images/progress.png"),
                             ),
                             color: Color.fromARGB(255, 183, 161, 233),
                             borderRadius: BorderRadius.circular(30)),
                       ),
                     ),
                     Text(
                       'SplashVideo',
                       style: GoogleFonts.aDLaMDisplay(),
                     ),
                   ]),
                  
                   
                    Column(children: [
                     
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const time_date()));
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/date_time.png"),
                              ),
                              color: Color.fromARGB(255, 118, 76, 216),
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                       Text(
                        'Time-date',
                        style: GoogleFonts.aDLaMDisplay(),
                      ),
                    ]),
                   
                    Column(children: [
                      
                     GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const time_date()));
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/app_bar.png'),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'App-Bar',
                        style: GoogleFonts.aDLaMDisplay(),
                      ),
                    ]),
                    Column(children: [
                      
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const splashSc_progres()));
                        },
                        child: Container(
                         height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/wel_come.png"),
                              ),
                              color: const Color.fromARGB(255, 243, 245, 246),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      RichText(
                        text: const TextSpan(
                            text: 'well',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 80, 43, 244),
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'C',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic)),
                              TextSpan(
                                  text: 'ome',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 78, 186, 235),
                                  ))
                            ]),
                      ),
                    ]),
                    Column(children: [
                      
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => splashSc_progres()));
                        },
                        child: Container(
                         height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/cart.png'),
                            ),
                          ),
                        ),
                      ),
                      RichText(
                        text: const TextSpan(
                            text: 'c',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 80, 43, 244),
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'A',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic)),
                              TextSpan(
                                  text: 'rt',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 78, 186, 235),
                                  ))
                            ]),
                      ),
                    ]),
                   Column(children: [
                    
                     GestureDetector(
                       onTap: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => const app_bar()));
                       },
                       child: Container(
                         height: 60,
                          width: 60,
                         decoration: BoxDecoration(
                             image: const DecorationImage(
                               fit: BoxFit.cover,
                               image: AssetImage("assets/images/radio_button.png"),
                             ),
                             color: Color.fromARGB(255, 216, 202, 249),
                             borderRadius: BorderRadius.circular(30)),
                       ),
                     ),
                      RichText(
                        text: const TextSpan(
                            text: 'radio',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 80, 43, 244),
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'B',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic)),
                              TextSpan(
                                  text: 'utton',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 78, 186, 235),
                                  ))
                            ]),
                      ),
                   ]),
                   
                  ],
                ),
      
                //   GridView.builder(
                //     scrollDirection: Axis.vertical,
                //     shrinkWrap: true,
                //     physics: PageScrollPhysics(parent: BouncingScrollPhysics()),
                //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //         crossAxisCount: 4, crossAxisSpacing: 5, mainAxisSpacing: 5),
                //     itemCount: _yourList.length,
                //     itemBuilder: (context, int index) {
                //       return _buitlerGridView(index);
                //     },
                //   )
              ],
            ),
          ),
         
         
      ),
    );
  }
}
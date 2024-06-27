import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sketch/helpers/responsive.dart';
import 'package:sketch/screen/app_bar.dart';
import 'package:sketch/screen/bottom_navigation.dart';
import 'package:sketch/screen/cart.dart';
import 'package:sketch/screen/cart_menu.dart';
import 'package:sketch/screen/check_box.dart';
import 'package:sketch/screen/date_time.dart';
import 'package:sketch/screen/hide_view.dart';
import 'package:sketch/screen/list_view.dart';
import 'package:sketch/screen/login.dart';
import 'package:sketch/screen/map_screen.dart';
import 'package:sketch/screen/menu_buton.dart';
import 'package:sketch/screen/page_scroll(link).dart';
import 'package:sketch/screen/pop_up.dart';
import 'package:sketch/screen/radio_button.dart';
import 'package:sketch/screen/scroll_video.dart';
import 'package:sketch/screen/send_mail.dart';
import 'package:sketch/screen/signPad_BarCode.dart';
import 'package:sketch/screen/sign_up.dart';
import 'package:sketch/screen/splashSc_progres.dart';
import 'package:sketch/screen/stepper.dart';
import 'package:sketch/screen/tabs_screen.dart';
import 'package:sketch/screen/text_msg.dart';
import 'package:sketch/screen/wel_come.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  // camera classes and variables strart
  File? _selectedImage;
  _showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Take a picture'),
              onTap: () {
                _openCamera(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Select from gallery'),
              onTap: () {
                _openGallery(context);
              },
            ),
          ],
        );
      },
    );
  }
  void _openCamera(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _selectedImage = File(pickedFile!.path);
    });
    Navigator.pop(context);
  }

  void _openGallery(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = File(pickedFile!.path);
    });
    Navigator.pop(context);
  }
// end the code of camera objects and class
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
          shadowColor: Color.fromARGB(255, 148, 218, 248),
          backgroundColor: Color.fromARGB(255, 134, 196, 223),
      
          title:Row(
            children: [
              Column(
              children: [
                const SizedBox(height: (0)),
                InkWell(
                  onTap: () => _showImagePickerBottomSheet(context),
                  child: Stack(
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: Color.fromARGB(255, 5, 5, 5),
                            ),
                            image: _selectedImage != null
                                ? DecorationImage(
                                    image: FileImage(_selectedImage!),
                                    fit: BoxFit.fill,
                                  )
                                : const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/profile.png")), // Fallback in case no image is selected
                          )),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Color.fromARGB(255, 248, 50, 50),
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                  
                            ],
                      ),
                      SizedBox(width: 20,),
                      const Text(
                          'Ali Raza',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 25,
                               fontStyle: FontStyle.italic,
                               
                              fontWeight: FontWeight.w900),
                        ),
            ],
          ),
        
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
                       'Splash-Vid',
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
                                      const app_bar()));
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
                     RichText(
                        text: const TextSpan(
                            text: 'App',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 80, 43, 244),
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Ba',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic)),
                              TextSpan(
                                  text: 'r',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 234, 133, 117),
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
                                  builder: (context) => const wel_come()));
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
                                      fontSize: 12,
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
                                  builder: (context) => MenuScreen()));
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
                                      fontSize: 12,
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
                                 builder: (context) => const RadioButton()));
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
                                      fontSize: 12,
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
                    Column(children: [
                    
                     GestureDetector(
                       onTap: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => const hide_view()));
                       },
                       child: Container(
                         height: 60,
                          width: 60,
                         decoration: BoxDecoration(
                             image: const DecorationImage(
                               fit: BoxFit.cover,
                               image: AssetImage("assets/images/hide_view.png"),
                             ),
                             color: Color.fromARGB(255, 255, 255, 255),
                             borderRadius: BorderRadius.circular(10)),
                       ),
                     ),
                     const Text('Hide-View')
                   ]),
                   Column(children: [
                    
                     GestureDetector(
                       onTap: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => const checkBox()));
                       },
                       child: Container(
                         height: 60,
                          width: 60,
                         decoration: BoxDecoration(
                             image: const DecorationImage(
                               fit: BoxFit.cover,
                               image: AssetImage("assets/images/check_box.png"),
                             ),
                             color: Color.fromARGB(255, 255, 255, 255),
                             borderRadius: BorderRadius.circular(30)),
                       ),
                     ),
                     const Text('Check Box')
                   ]),
                   Column(children: [
                    
                     GestureDetector(
                       onTap: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => const MenuButon()));
                       },
                       child: Container(
                         height: 60,
                          width: 60,
                         decoration: BoxDecoration(
                             image: const DecorationImage(
                               fit: BoxFit.cover,
                               image: AssetImage("assets/images/menu_buton.png"),
                             ),
                             color: Color.fromARGB(255, 255, 255, 255),
                             borderRadius: BorderRadius.circular(10)),
                       ),
                     ),
                     const Text('Menu Button')
                   ]),
                   Column(children: [
                    
                     GestureDetector(
                       onTap: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => const PopUp()));
                       },
                       child: Container(
                         height: 60,
                          width: 60,
                         decoration: BoxDecoration(
                             image: const DecorationImage(
                               fit: BoxFit.cover,
                               image: AssetImage("assets/images/pop_up.png"),
                             ),
                             color: Color.fromARGB(255, 255, 255, 255),
                             borderRadius: BorderRadius.circular(10)),
                       ),
                     ),
                     const Text('Pop Up')
                   ]),
                    Column(children: [
                    
                     GestureDetector(
                       onTap: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => const SendMail()));
                       },
                       child: Container(
                         height: 60,
                          width: 60,
                         decoration: BoxDecoration(
                             image: const DecorationImage(
                               fit: BoxFit.cover,
                               image: AssetImage("assets/images/send_mail.png"),
                             ),
                             color: Color.fromARGB(255, 255, 255, 255),
                             borderRadius: BorderRadius.circular(10)),
                       ),
                     ),
                     const Text('Send Mail')
                   ]),
                   Column(children: [
                    
                     GestureDetector(
                       onTap: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => const ListViewScreen()));
                       },
                       child: Container(
                         height: 60,
                          width: 60,
                         decoration: BoxDecoration(
                             image: const DecorationImage(
                               fit: BoxFit.cover,
                               image: AssetImage("assets/images/list_view.png"),
                             ),
                             color: Color.fromARGB(255, 255, 255, 255),
                             borderRadius: BorderRadius.circular(10)),
                       ),
                     ),
                     const Text('List View')
                   ]),
                    Column(children: [
                    
                     GestureDetector(
                       onTap: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => const PageScroll()));
                       },
                       child: Container(
                         height: 60,
                          width: 60,
                         decoration: BoxDecoration(
                             image: const DecorationImage(
                               fit: BoxFit.cover,
                               image: AssetImage("assets/images/pageview_scroll.png"),
                             ),
                             color: Color.fromARGB(255, 255, 255, 255),
                             borderRadius: BorderRadius.circular(10)),
                       ),
                     ),
                     const Text('Page Scroll')
                   ]),
                    Column(children: [
                    
                     GestureDetector(
                       onTap: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => const tabs_screen()));
                       },
                       child: Container(
                         height: 60,
                          width: 60,
                         decoration: BoxDecoration(
                             image: const DecorationImage(
                               fit: BoxFit.cover,
                               image: AssetImage("assets/images/tabs_screen.png"),
                             ),
                             color: Color.fromARGB(255, 255, 255, 255),
                             borderRadius: BorderRadius.circular(5)),
                       ),
                     ),
                     const Text('Tabs Screen')
                   ]),
                   Column(children: [
                    
                     GestureDetector(
                       onTap: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => const MapScreen()));
                       },
                       child: Container(
                         height: 60,
                          width: 60,
                         decoration: BoxDecoration(
                             image: const DecorationImage(
                               fit: BoxFit.cover,
                               image: AssetImage("assets/images/map_screen.png"),
                             ),
                             color: Color.fromARGB(255, 255, 255, 255),
                             borderRadius: BorderRadius.circular(5)),
                       ),
                     ),
                     const Text('Google Map')
                   ]),
                    Column(children: [
                    
                     GestureDetector(
                       onTap: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => const bottombar()));
                       },
                       child: Container(
                         height: 60,
                          width: 60,
                         decoration: BoxDecoration(
                             image: const DecorationImage(
                               fit: BoxFit.cover,
                               image: AssetImage("assets/images/bottom_navigation.png"),
                             ),
                             color: Color.fromARGB(255, 255, 255, 255),
                             borderRadius: BorderRadius.circular(5)),
                       ),
                     ),
                     const Text('Navigation')
                   ]),
                    Column(children: [
                    
                     GestureDetector(
                       onTap: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => const Signature_barCode()));
                       },
                       child: Container(
                         height: 60,
                          width: 60,
                         decoration: BoxDecoration(
                             image: const DecorationImage(
                               fit: BoxFit.cover,
                               image: AssetImage("assets/images/signpad_barcode].png"),
                             ),
                             color: const Color.fromARGB(255, 255, 255, 255),
                             borderRadius: BorderRadius.circular(5)),
                       ),
                     ),
                     const Text('SignBarcode')
                   ]),
                   Column(children: [
                    
                     GestureDetector(
                       onTap: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => const scrol_video()));
                       },
                       child: Container(
                         height: 60,
                          width: 60,
                         decoration: BoxDecoration(
                             image: const DecorationImage(
                               fit: BoxFit.cover,
                               image: AssetImage("assets/images/scroll_video.png"),
                             ),
                             color: const Color.fromARGB(255, 255, 255, 255),
                             borderRadius: BorderRadius.circular(5)),
                       ),
                     ),
                     const Text('Scrol Video')
                   ]),
                   Column(children: [
                    
                     GestureDetector(
                       onTap: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) =>  Stepper_Class()));
                       },
                       child: Container(
                         height: 60,
                          width: 60,
                         decoration: BoxDecoration(
                             image: const DecorationImage(
                               fit: BoxFit.cover,
                               image: AssetImage("assets/images/video-call.png"),
                             ),
                             color: const Color.fromARGB(255, 255, 255, 255),
                             borderRadius: BorderRadius.circular(5)),
                       ),
                     ),
                     const Text('Message')
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
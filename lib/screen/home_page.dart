import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketch/helpers/responsive.dart';
import 'package:sketch/screen/PostApi_LoginUser.dart';
import 'package:sketch/screen/actualPostCreate.dart';
import 'package:sketch/screen/actual_loin_preferrance.dart';
import 'package:sketch/screen/app_bar.dart';
import 'package:sketch/screen/bottom_navigation.dart';
import 'package:sketch/screen/change_language.dart';
import 'package:sketch/screen/check_box.dart';
import 'package:sketch/screen/date_time.dart';
import 'package:sketch/screen/download_img.dart';
import 'package:sketch/screen/e_mail.dart';
import 'package:sketch/screen/getApiPost.dart';
import 'package:sketch/screen/hide_view.dart';
import 'package:sketch/screen/image_url.dart';
import 'package:sketch/screen/list_view.dart';
import 'package:sketch/screen/login.dart';
import 'package:sketch/screen/map_screen.dart';
import 'package:sketch/screen/menu_buton.dart';
import 'package:sketch/screen/page_scroll(link).dart';
import 'package:sketch/screen/pick_audio_docx.dart';
import 'package:sketch/screen/pick_image_video.dart';
import 'package:sketch/screen/pop_up.dart';
import 'package:sketch/screen/preferences.dart';
import 'package:sketch/screen/radio_button.dart';
import 'package:sketch/screen/realApi.dart.dart';
import 'package:sketch/screen/recording2.dart';
import 'package:sketch/screen/reqresApi.dart.dart';
import 'package:sketch/screen/screenshot.dart';
import 'package:sketch/screen/scroll_video.dart';
import 'package:sketch/screen/signPad_BarCode.dart';
import 'package:sketch/screen/sign_up.dart';
import 'package:sketch/screen/splashSc_progres.dart';
import 'package:sketch/screen/stepper.dart';
import 'package:sketch/screen/tabs_screen.dart';
import 'package:sketch/screen/text_msg.dart';
import 'package:sketch/screen/wel_come.dart';

class home_page extends StatefulWidget {
  static const routeName = '/home_page';
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
   Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn'); // Clear login state
    Navigator.pushReplacementNamed(context, SignupScreen.routeName);
  }
  
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
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Text(
                          'Sketch ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 1, 1, 17),
                              fontSize:
                                  Responsive.isMobile(context) ? 30 : 20,
                              // fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w900),
                        ),
          elevation: 10,
          shadowColor: Color.fromARGB(255, 148, 218, 248),
          backgroundColor: Color.fromARGB(255, 134, 196, 223),
        
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
                    // Container(
                    //   height: 80,
                    //   width: 80,
                    //   decoration: const BoxDecoration(
                    //     image: DecorationImage(
                    //       image: AssetImage('assets/images/profile.png'),
                    //     ),
                    //   ),
                    // ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                          'Ali Raza',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 25,
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
                          height: 190,
                          width: 60,
                        ),
                      ],
                    ),
                    GestureDetector(
                     onTap: () {
                _logout(context);
              },
                      child: Container(
                       
                        color: Color.fromARGB(255, 51, 171, 180),
                        height: 50,
                        width: 200,
                        margin: EdgeInsets.symmetric(vertical: 70),
                        alignment: Alignment.bottomCenter,
                        child: const Center(
                          child: Text(
                            "LogOut",
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
       
        
         body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"), fit: BoxFit.cover),),
           child: SingleChildScrollView(
             child: Expanded(
              child:   GridView(
                       scrollDirection: Axis.vertical,
                       shrinkWrap: true,
                       physics: PageScrollPhysics(parent: BouncingScrollPhysics()),
                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 4, crossAxisSpacing: 5, mainAxisSpacing: 5),
                     children: [
                      GridTileofApp(image: 'assets/images/login.png', screenName: 'LoginReal'),
                      GridTileofApp(image: 'assets/images/sign_up.png', screenName: 'signup',fontsize: 14.5,),
                      GridTileofApp(image: 'assets/images/progress.png', screenName: 'SplashVid'),
                      GridTileofApp(image: 'assets/images/date_time.png', screenName: 'DateTime'),
                      GridTileofApp(image: 'assets/images/app_bar.png', screenName: 'AppBar'),
                      GridTileofApp(image: 'assets/images/wel_come.png', screenName: 'WelCome'),
                      GridTileofApp(image: 'assets/images/radio_button.png', screenName: 'RadioBtn'),
                      GridTileofApp(image: 'assets/images/hide_view.png', screenName: 'HideView'),
                      GridTileofApp(image: 'assets/images/check_box.png', screenName: 'CheckBox'),
                      GridTileofApp(image: 'assets/images/menu_buton.png', screenName: 'Menu'),
                      GridTileofApp(image: 'assets/images/pop_up.png', screenName: 'PopUp'),
                      GridTileofApp(image: 'assets/images/send_mail.png', screenName: 'Mail'),
                      GridTileofApp(image: 'assets/images/list_view.png', screenName: 'listView'),
                      GridTileofApp(image: 'assets/images/pageview_scroll.png', screenName: 'Pagescrol'),
                      GridTileofApp(image: 'assets/images/tabs_screen.png', screenName: 'TabScreen'),
                      GridTileofApp(image: 'assets/images/map_screen.png', screenName: 'Map'),
                      GridTileofApp(image: 'assets/images/bottom_navigation.png', screenName: 'B-Navigate'),
                      GridTileofApp(image: 'assets/images/signpad_barcode].png', screenName: 'Sign-Bar'),
                      GridTileofApp(image: 'assets/images/scroll_video.png', screenName: 'ScrolVideo'),
                      GridTileofApp(image: 'assets/images/message.png', screenName: 'Message'),
                      GridTileofApp(image: 'assets/images/language.png', screenName: 'Language'),
                      GridTileofApp(image: 'assets/images/stepper.png', screenName: 'Stepper'),
                      GridTileofApp(image: 'assets/images/sound_recording.png', screenName: 'S-Record'),
                      GridTileofApp(image: 'assets/images/pick_img_video.png', screenName: 'ImgVid'),
                      GridTileofApp(image: 'assets/images/pick_aud_docx.png', screenName: 'AudDocx'),
                      GridTileofApp(image: 'assets/images/sound_recording.png', screenName: 'Preferences'),
                      GridTileofApp(image: 'assets/images/screenshot.png', screenName: 'screenshot'),
                      GridTileofApp(image: 'assets/images/screenshot.png', screenName: 'SaveImage'),
                      GridTileofApp(image: 'assets/images/screenshot.png', screenName: 'ImageUrl'),
                      // GridTileofApp(image: 'assets/images/getApi.png', screenName: 'GetApi'),
                      // GridTileofApp(image: 'assets/images/getApi.png', screenName: 'Link'),
                      // GridTileofApp(image: 'assets/images/getApi.png', screenName: 'Provider'),
                      // GridTileofApp(image: 'assets/images/getApi.png', screenName: 'SingleUser'),
                      // GridTileofApp(image: 'assets/images/getApi.png', screenName: 'FindUser'),
                      // GridTileofApp(image: 'assets/images/getApi.png', screenName: 'Resource'),
                     // GridTileofApp(image: 'assets/images/postApi.png', screenName: 'UserList'),
                     // GridTileofApp(image: 'assets/images/ApiUpdate.png', screenName: 'ProfileUpd'),
                     //  GridTileofApp(image: 'assets/images/postApi.png', screenName: 'Register'),
                     //  GridTileofApp(image: 'assets/images/postApi.png', screenName: 'Register2'),
                     //  GridTileofApp(image: 'assets/images/postApi.png', screenName: 'Login'),
                     // GridTileofApp(image: 'assets/images/ApiDelete.png', screenName: 'Delete User'),
                     // GridTileofApp(image: 'assets/images/ApiDelete.png', screenName: 'Actual Register'),
                     // GridTileofApp(image: 'assets/images/ApiDelete.png', screenName: 'Actual Login'),
                     // GridTileofApp(image: 'assets/images/ApiDelete.png', screenName: 'Ac RegLogin'),
                     // GridTileofApp(image: 'assets/images/ApiDelete.png', screenName: 'Connectivity'),
                     // GridTileofApp(image: 'assets/images/ApiDelete.png', screenName: 'Pre login'),
                      GridTileofApp(image: 'assets/images/loginfolder.png', screenName: 'Reqres Api'),
                      GridTileofApp(image: 'assets/images/registerfolder.png', screenName: 'Real Api'),
                      
                     
                     
                     ],
                     ),
                ),
                ),
         ),
     ),
     );
         
         
     
  }
}



class GridTileofApp extends StatelessWidget {
   GridTileofApp({
    super.key,
    required this.image,
    required this.screenName,
    this.fontsize=15,
  });

  final String image;
  final String screenName;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
   // final data = ModalRoute.of(context)?.settings.arguments;

    return GestureDetector(
      onTap: () {
        if (screenName == 'LoginReal') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CheckAuthLogin(),));
        }
         if (screenName == 'signup') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CheckAuthUi(),));
        }
         if (screenName == 'SplashVid') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => splashSc_progres(),));
        }
         if (screenName == 'DateTime') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => time_date(),));
        }
         if (screenName == 'AppBar') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => app_bar(),));
        }
         if (screenName == 'WelCome') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => wel_come(),));
        }
         if (screenName == 'RadioBtn') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RadioButton(),));
        }
         if (screenName == 'HideView') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => hide_view(),));
        }
         if (screenName == 'CheckBox') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => checkBox(),));
        }
         if (screenName == 'Menu') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MenuButon(),));
        }
         if (screenName == 'PopUp') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PopUp(),));
        }
         if (screenName == 'Mail') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => e_mail(),));
        }
         if (screenName == 'listView') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ListViewScreen(),));
         }
          if (screenName == 'Pagescrol') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PageScroll(),));
        }
         if (screenName == 'TabScreen') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => tabs_screen(),));
        }
         if (screenName == 'Map') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen(),));
        }
         if (screenName == 'B-Navigate') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => bottombar(),));
        }
         if (screenName == 'Sign-Bar') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Signature_barCode(),));
        }
         if (screenName == 'ScrolVideo') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => scrol_video(),));
        }
         if (screenName == 'Message') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Message(),));
        }
         if (screenName == 'Language') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => chang_language(),));
        }
         if (screenName == 'Stepper') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Stepper_Class(),));
        }
        if (screenName == 'S-Record') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SoundRecording(),));
        } 
         if (screenName == 'ImgVid') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ImageVideo(),));
        }
         if (screenName == 'AudDocx') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AudioDocx(),));
        }
          if (screenName == 'Preferrences') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PreferencesScreen(),));
        } 
         if (screenName == 'screenshot') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenShot(),));
        } 
         if (screenName == 'SaveImage') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ImageSaveToGallery(),));
        } 
         if (screenName == 'ImageUrl') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ImageUrl(),));
        }
         if (screenName == 'Login') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginUser(),));
        }
         if (screenName == 'Reqres Api') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ReqresApi(),));
        } 
         if (screenName == 'Real Api') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RealApi(),));
        }
         
        
        
                                     
    

      },
      child: Column(
        children: [
          Image(
            image: AssetImage(image),
            width: 55,
            height: 55,
          ),
          const SizedBox(height: 10),
          Text(screenName, style:  TextStyle(fontSize:fontsize)),
          //Text(secondText, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

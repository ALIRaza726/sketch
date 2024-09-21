import 'dart:io';

import 'package:easy_localization/easy_localization.dart' ;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketch/helpers/responsive.dart';
import 'package:sketch/screen/checking.dart';
import 'package:sketch/screen/reqres_api/PostApi_LoginUser.dart';
import 'package:sketch/screen/app_bar.dart';
import 'package:sketch/screen/bottom_navigation.dart';
import 'package:sketch/screen/change_language.dart';
import 'package:sketch/screen/check_box.dart';
import 'package:sketch/screen/date_time.dart';
import 'package:sketch/screen/download_img.dart';
import 'package:sketch/screen/e_mail.dart';
import 'package:sketch/screen/facebook_login.dart';
import 'package:sketch/screen/hide_view.dart';
import 'package:sketch/screen/image_url.dart';
import 'package:sketch/screen/list_view.dart';
import 'package:sketch/screen/actual_api/login_real.dart';
import 'package:sketch/screen/map_screen.dart';
import 'package:sketch/screen/menu_buton.dart';
import 'package:sketch/screen/page_scroll(link).dart';
import 'package:sketch/screen/pick_audio_docx.dart';
import 'package:sketch/screen/pick_image_video.dart';
import 'package:sketch/screen/popUp_timer.dart';
import 'package:sketch/screen/pop_up.dart';
import 'package:sketch/screen/preferences.dart';
import 'package:sketch/screen/radio_button.dart';
import 'package:sketch/screen/actual_api/realApi.dart.dart';
import 'package:sketch/screen/recording2.dart';
import 'package:sketch/screen/reqres_api/reqresApi.dart.dart';
import 'package:sketch/screen/screenshot.dart';
import 'package:sketch/screen/scroll_video.dart';
import 'package:sketch/screen/signPad_BarCode.dart';
import 'package:sketch/screen/actual_api/sign_up.dart';
import 'package:sketch/screen/splashSc_progres.dart';
import 'package:sketch/screen/stepper.dart';
import 'package:sketch/screen/tabs_screen.dart';
import 'package:sketch/screen/text_msg.dart';
import 'package:sketch/screen/wel_come.dart';
import 'package:sketch/utils/routes/route_name.dart';

class home_page extends StatefulWidget {
  static const routeName = '/home_page';
  const home_page({super.key});
// String active;

  
//    home_page({Key? key, required this.active}) : super(key: key);
  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {

  //Popup  
   Future popupDialog() {
    return showDialog(
      barrierColor: Colors.black54,
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          
          iconColor: Colors.black,
          backgroundColor: Color.fromARGB(255, 195, 192, 192),
          title: const Text('Log Out').tr(),
          content: const Text('Are you sure you want to log out').tr(),
          actions: [
            TextButton(
                onPressed: () {
                  // Navigator.pop(context);
                  _logout(context);
                },
                child: const Text("OK").tr())
          ],
        );
      },
    );
  }

   Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('isLoggedIn'); // Clear login state
    Navigator.pushReplacementNamed(context, RouteName.login);
     print('logout:');
      print('preferance:${prefs.toString()}');
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
                          ("Sketch"),
                          style: TextStyle(
                              color: Color.fromARGB(255, 38, 56, 61),
                              fontSize:
                                  Responsive.isMobile(context) ? 30 : 20,
                              // fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w900),
                        ).tr(),
          elevation: 10,
          shadowColor: Color.fromARGB(255, 148, 218, 248),
          backgroundColor: Color.fromARGB(255, 134, 196, 223),
          actions: [
              IconButton(
                  onPressed: () {
                    popupDialog();
                  },
                  icon: const Icon(Icons.logout_rounded,size: 35,))]
        
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
                     Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child:  Text(
                          ("Ali Raza"),
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 25,
                               fontStyle: FontStyle.italic,
                               
                              fontWeight: FontWeight.w900),
                        ).tr(),
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
                          'User Name:',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 1, 1, 17),
                            fontSize:
                                Responsive.isMobile(context) ? 15: 20,
                          ),
                        ).tr(),
                        Text(
                          ('Ali Raza'),
                          style: TextStyle(
                              color: Color.fromARGB(255, 1, 1, 17),
                              fontSize:
                                  Responsive.isMobile(context) ? 15 : 20,
                              // fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w900),
                        ).tr(),
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
                        ).tr(),
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
                     Row(
                      children: [
                        Text(
                          'Password:    '.tr(),
                          style: TextStyle(
                            color: Color.fromARGB(255, 1, 1, 17),
                            fontSize: 10,
                          ),
                        ),
                       const Text(
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
                            '<< Back',
                            style: TextStyle(
                                color: Color.fromARGB(255, 1, 1, 17),
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ).tr(),
                        ),
                         
                        const SizedBox(
                          height: 190,
                          width: 60,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Change language to English
                context.setLocale(Locale('en', 'US'));
              },
              child: Text('Change to English').tr(),
            ),
            ElevatedButton(
              onPressed: () {
                // Change language to Urdu
                context.setLocale(Locale('ur', 'PK'));
              },
              child: Text('Change to Urdu').tr(),
            ),
                    GestureDetector(
                     onTap: () {
                _logout(context);
              },
                      child: Container(
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Color.fromARGB(255, 51, 171, 180),
                       ),
                         
                        height: 50,
                        width: 220,
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
           child: Column(
             children: [
               Expanded(
                child:   GridView(
                         scrollDirection: Axis.vertical,
                         shrinkWrap: true,
                         physics: PageScrollPhysics(parent: BouncingScrollPhysics()),
                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                             crossAxisCount: 4, crossAxisSpacing: 5, mainAxisSpacing: 5),
                       children: [
                        GridTileofApp(image: 'assets/images/login.png', screenName: 'LoginReal'.tr()),
                        GridTileofApp(image: 'assets/images/sign_up.png', screenName: 'signup'.tr(),fontsize: 14.5,),
                        GridTileofApp(image: 'assets/images/progress.png', screenName: 'SplashVid'.tr()),
                        GridTileofApp(image: 'assets/images/date_time.png', screenName: 'DateTime'.tr()),
                        GridTileofApp(image: 'assets/images/app_bar.png', screenName: 'AppBar'.tr()),
                        GridTileofApp(image: 'assets/images/wel_come.png', screenName: 'WelCome'.tr()),
                        GridTileofApp(image: 'assets/images/radio_button.png', screenName: 'RadioBtn'.tr()),
                        GridTileofApp(image: 'assets/images/hide_view.png', screenName: 'HideView'.tr()),
                        GridTileofApp(image: 'assets/images/check_box.png', screenName: 'CheckBox'.tr()),
                        GridTileofApp(image: 'assets/images/menu_buton.png', screenName: 'Menu'),
                        GridTileofApp(image: 'assets/images/pop_up.png', screenName: 'PopUp'.tr()),
                        GridTileofApp(image: 'assets/images/send_mail.png', screenName: 'Mail'.tr()),
                        GridTileofApp(image: 'assets/images/list_view.png', screenName: 'listView'.tr()),
                        GridTileofApp(image: 'assets/images/pageview_scroll.png', screenName: 'Pagescrol'.tr()),
                        GridTileofApp(image: 'assets/images/tabs_screen.png', screenName: 'TabScreen'.tr()),
                        GridTileofApp(image: 'assets/images/map_screen.png', screenName: 'Map'.tr()),
                        GridTileofApp(image: 'assets/images/bottom_navigation.png', screenName: 'B-Navigate'.tr()),
                        GridTileofApp(image: 'assets/images/signpad_barcode].png', screenName: 'Sign-Bar'.tr()),
                        GridTileofApp(image: 'assets/images/scroll_video.png', screenName: 'ScrolVideo'.tr()),
                        GridTileofApp(image: 'assets/images/message.png', screenName: 'Message'.tr()),
                        GridTileofApp(image: 'assets/images/language.png', screenName: 'Language'.tr()),
                        GridTileofApp(image: 'assets/images/stepper.png', screenName: 'Stepper'.tr()),
                        GridTileofApp(image: 'assets/images/sound_recording.png', screenName: 'S-Record'.tr()),
                        GridTileofApp(image: 'assets/images/pick_img_video.png', screenName: 'ImgVid'.tr()),
                        GridTileofApp(image: 'assets/images/pick_aud_docx.png', screenName: 'AudDocx'.tr()),
                        GridTileofApp(image: 'assets/images/sound_recording.png', screenName: 'Pref'.tr()),
                        GridTileofApp(image: 'assets/images/screenshot.png', screenName: 'screenshot'.tr()),
                        GridTileofApp(image: 'assets/images/screenshot.png', screenName: 'SaveImage'.tr()),
                        GridTileofApp(image: 'assets/images/screenshot.png', screenName: 'ImageUrl'.tr()),
                        GridTileofApp(image: 'assets/images/pop_up.png', screenName: 'PopUpTimer'.tr()),
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
                        GridTileofApp(image: 'assets/images/loginfolder.png', screenName: 'Reqres Api'.tr()),
                        GridTileofApp(image: 'assets/images/registerfolder.png', screenName: 'Real Api'.tr()),
                        GridTileofApp(image: 'assets/images/registerfolder.png', screenName: 'AuthFace'.tr()),
                       
                        
                       
                       
                       ],
                       ),
                  ),
             ],
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
        if (screenName == 'LoginReal'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CheckAuthLogin(),));
        }
         if (screenName == 'signup'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CheckAuthUi(),));
        }
         if (screenName == 'SplashVid'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => splashSc_progres(),));
        }
         if (screenName == 'DateTime'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => time_date(),));
        }
         if (screenName == 'AppBar'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => app_bar(),));
        }
         if (screenName == 'WelCome'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => wel_come(),));
        }
         if (screenName == 'RadioBtn'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RadioButton(),));
        }
         if (screenName == 'HideView'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => hide_view(),));
        }
         if (screenName == 'CheckBox'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => checkBox(),));
        }
         if (screenName == 'Menu'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MenuButon(),));
        }
         if (screenName == 'PopUp'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PopUp(),));
        }
         if (screenName == 'Mail'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => e_mail(),));
        }
         if (screenName == 'listView'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ListViewScreen(),));
         }
          if (screenName == 'Pagescrol'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PageScroll(),));
        }
         if (screenName == 'TabScreen'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => tabs_screen(),));
        }
         if (screenName == 'Map'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen(),));
        }
         if (screenName == 'B-Navigate'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => bottombar(),));
        }
         if (screenName == 'Sign-Bar'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Signature_barCode(),));
        }
         if (screenName == 'ScrolVideo'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => scrol_video(),));
        }
         if (screenName == 'Message'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Message(),));
        }
         if (screenName == 'Language'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => chang_language(),));
        }
         if (screenName == 'Stepper'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Stepper_Class(),));
        }
        if (screenName == 'S-Record'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SoundRecording(),));
        } 
         if (screenName == 'ImgVid'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ImageVideo(),));
        }
         if (screenName == 'AudDocx'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AudioDocx(),));
        }
          if (screenName == 'Pref'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PreferencesScreen(),));
        } 
         if (screenName == 'screenshot'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenShot(),));
        } 
         if (screenName == 'SaveImage'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ImageSaveToGallery(),));
        } 
         if (screenName == 'ImageUrl'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ImageUrl(),));
        }
         if (screenName == 'Login'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginUser(),));
        }
        if (screenName == 'PopUpTimer'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PopUpTimer(),));
        }
         if (screenName == 'Reqres Api'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ReqresApi(),));
        } 
         if (screenName == 'Real Api'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RealApi(),));
        }
        if (screenName == 'AuthFace'.tr()) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => UserName(),));
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
          Text(screenName.tr(), style:  TextStyle(fontSize:fontsize)),
          //Text(secondText, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

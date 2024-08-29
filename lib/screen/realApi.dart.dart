import 'package:flutter/material.dart';
import 'package:sketch/screen/actualApi_login.dart';
import 'package:sketch/screen/actualApi_register.dart';
import 'package:sketch/screen/actualPostCreate.dart';
import 'package:sketch/screen/actual_loin_preferrance.dart';
import 'package:sketch/screen/actual_reg_login.dart';
import 'package:sketch/screen/chkConectivity.dart';
import 'package:sketch/screen/login.dart';
import 'package:sketch/screen/sign_up.dart';

class RealApi extends StatefulWidget {
  const RealApi({super.key});

  @override
  State<RealApi> createState() => _RealApiState();
}

class _RealApiState extends State<RealApi> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title:Text("Real Database Api's"),
        backgroundColor: Color.fromARGB(255, 108, 213, 234),
        ),
        body: SingleChildScrollView(
             child: Expanded(
              child:   GridView(
                       scrollDirection: Axis.vertical,
                       shrinkWrap: true,
                       physics: PageScrollPhysics(parent: BouncingScrollPhysics()),
                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 4, crossAxisSpacing: 5, mainAxisSpacing: 5),
                     children: [
                      GridTileofApp(image: 'assets/images/sign_up.png', screenName: 'Register'),
                      GridTileofApp(image: 'assets/images/sign_up.png', screenName: 'RegLogin'),
                      GridTileofApp(image: 'assets/images/sign_up.png', screenName: 'RealSignUP'),
                      GridTileofApp(image: 'assets/images/login.png', screenName: 'LoginReal'),
                      GridTileofApp(image: 'assets/images/login.png', screenName: 'Prefrances'),
                      GridTileofApp(image: 'assets/images/login.png', screenName: 'Net-Conection'),
                      GridTileofApp(image: 'assets/images/login.png', screenName: 'Login'),
                       GridTileofApp(image: 'assets/images/postApi.png', screenName: 'PostCreate'),
                     
                     
                    
                     ],
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
        
        if (screenName == 'Register') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
        }
         if (screenName == 'RegLogin') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterLogin(),));
        }
        
         if (screenName == 'RealSignUP') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CheckAuthUi(),));
        } 

         if (screenName == 'LoginReal') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CheckAuthLogin(),));
        }
         if (screenName == 'Prefrances') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CheckAuthScreen(),));
        }
         if (screenName == 'Net-Conection') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => chkConnectivity(),));
        }
        if (screenName == 'Login') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => actualLogin(),));
        } 
         if (screenName == 'PostCreate') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePostPage(),));
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
      ));
    
  
  }
}
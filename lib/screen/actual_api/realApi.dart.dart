import 'package:flutter/material.dart';
import 'package:sketch/screen/actual_api/actualApi_login.dart';
import 'package:sketch/screen/actual_api/actualApi_register.dart';
import 'package:sketch/screen/actual_api/actualPostCreate.dart';
import 'package:sketch/screen/actual_api/actual_loin_preferrance.dart';
import 'package:sketch/screen/actual_api/actual_reg_login.dart';
import 'package:sketch/screen/actual_api/search_actualApi.dart';
import 'package:sketch/screen/chkConectivity.dart';
import 'package:sketch/screen/actual_api/delete_actualAPi.dart';
import 'package:sketch/screen/actual_api/getApiPost.dart';
import 'package:sketch/screen/actual_api/login_real.dart';
import 'package:sketch/screen/actual_api/sign_up_real.dart';
import 'package:sketch/screen/actual_api/update_actualApi.dart';

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
        body: Column(
          children: [
            Expanded(
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
                     GridTileofApp(image: 'assets/images/login.png', screenName: 'Net-Con'),
                     GridTileofApp(image: 'assets/images/login.png', screenName: 'Login'),
                     GridTileofApp(image: 'assets/images/postApi.png', screenName: 'PostCreate'),
                     GridTileofApp(image: 'assets/images/registerfolder.png', screenName: 'GetApi'),
                     GridTileofApp(image: 'assets/images/registerfolder.png', screenName: 'Update Api'),
                     GridTileofApp(image: 'assets/images/registerfolder.png', screenName: 'Delete Api'),
                     GridTileofApp(image: 'assets/images/registerfolder.png', screenName: 'Search Api'),
                    
                    
                   
                    ],
                    ),
                   ),
          ],
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChkAuthSignUp(),));
        } 

         if (screenName == 'LoginReal') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CheckAuthLogin(),));
        }
         if (screenName == 'Prefrances') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChkAuthPrefferance(),));
        }
         if (screenName == 'Net-Con') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => chkConnectivity(),));
        }
        if (screenName == 'Login') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => actualLogin(),));
        } 
         if (screenName == 'PostCreate') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePostPage(),));
        }
        if (screenName == 'GetApi') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => GetPostApi(),));
        }
        if (screenName == 'Update Api') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateActualApi(),));
        }
        if (screenName == 'Delete Api') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteActualApi(),));
        }
        if (screenName == 'Search Api') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateActualApi(),));
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
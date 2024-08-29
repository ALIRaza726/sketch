import 'package:flutter/material.dart';
import 'package:sketch/screen/DeleteApi.dart';
import 'package:sketch/screen/PostApi_AddUser.dart';
import 'package:sketch/screen/PostApi_LoginUser.dart';
import 'package:sketch/screen/PostApi_RegisterUser.dart';
import 'package:sketch/screen/PostApi_RegisterUser2.dart';
import 'package:sketch/screen/ResourcesApi_Screen.dart';
import 'package:sketch/screen/UpdateApi_UserProfile.dart';
import 'package:sketch/screen/getApi_Simple.dart';
import 'package:sketch/screen/getApi_findUser.dart';
import 'package:sketch/screen/getApi_provider.dart';
import 'package:sketch/screen/getApi_singleUser.dart';
import 'package:sketch/screen/gteApiLink.dart';

class ReqresApi extends StatefulWidget {
  const ReqresApi({super.key});

  @override
  State<ReqresApi> createState() => _ReqresApiState();
}

class _ReqresApiState extends State<ReqresApi> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 112, 166, 193),
          title: Text("Reqres Api's  "),
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
                      
                      GridTileofApp(image: 'assets/images/login.png', screenName: 'Login'),
                      GridTileofApp(image: 'assets/images/sign_up.png', screenName: 'SignUp-S'),
                      GridTileofApp(image: 'assets/images/sign_up.png', screenName: 'SignUp-Pro'),
                      GridTileofApp(image: 'assets/images/getApi.png', screenName: 'GetApi'),
                      GridTileofApp(image: 'assets/images/getApi.png', screenName: 'GetLink Profile'),
                      GridTileofApp(image: 'assets/images/getApi.png', screenName: 'GetProvider'),
                      GridTileofApp(image: 'assets/images/getApi.png', screenName: 'GetSingleUser'),
                      GridTileofApp(image: 'assets/images/getApi.png', screenName: 'GetFindUser'),
                      GridTileofApp(image: 'assets/images/getApi.png', screenName: 'GetResource'),
                      GridTileofApp(image: 'assets/images/postApi.png', screenName: 'UserList'),
                      GridTileofApp(image: 'assets/images/ApiUpdate.png', screenName: 'ProfileUpd'),
                      GridTileofApp(image: 'assets/images/ApiDelete.png', screenName: 'Delete User'),
                     
                    
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
       
        if (screenName == 'Login') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginUser(),));
        }

         if (screenName == 'GetApi') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => GetApiScreen(),));
        } 
        if (screenName == 'GetLink Profile') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => getApiLink(),));
        } 
          if (screenName == 'GetProvider') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => GetApiProvider(),));
        }
        if (screenName == 'GetSingleUser') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => UserScreen(),));
        } 
         if (screenName == 'GetFindUser') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => FindUserScreen(),));
        }  
         if (screenName == 'GetResource') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ResourceScreen(),));
        }
         if (screenName == 'SignUp-Pro') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterUserScreen(),));
        } 
         if (screenName == 'SignUp-S') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterUser2(),));
        }
        if (screenName == 'UserList') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => UserListPage(),));
        }
        if (screenName == 'ProfileUpd') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileForm(),));
        }
         if (screenName == 'Delete User') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteUser(),));
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
// import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sketch/helpers/ResourceProvider.dart';
import 'package:sketch/helpers/UpdateApi_UserProfile.dart';
import 'package:sketch/helpers/getAPi_Provider_class.dart';
import 'package:sketch/helpers/singleUser_provider.dart';
import 'package:sketch/models/cart.dart';
import 'package:sketch/models/listview_model.dart';
import 'package:sketch/models/menuBtn_provider.dart';
import 'package:sketch/screen/reqres_api/PostApi_RegisterUser.dart';
import 'package:sketch/screen/actual_api/actual_loin_preferrance.dart';
import 'package:sketch/screen/home_page.dart';
import 'package:sketch/screen/recording2.dart';
import 'package:sketch/screen/reqres_api/deleteApi.dart';
import 'package:sketch/utils/routes/route_name.dart';
import 'package:sketch/utils/routes/routes.dart';
// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//      ..badCertificateCallback = (X509Certificate cert, String host, int 
//     port)=> true;
//  }
// }


void main()  async{
   // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize EasyLocalization
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ur', 'PK')],
      path: 'assets/langs', // Path to your translations
      fallbackLocale: const Locale('en', 'US'),
      child: MultiProvider(
      providers: [
        ChangeNotifierProvider<CartModel>(create: (context) => CartModel()),
        ChangeNotifierProvider<RecordingProvider>(create: (context) => RecordingProvider()),
        ChangeNotifierProvider<MenuButtonProvider>(create: (context) => MenuButtonProvider()),
        ChangeNotifierProvider<ListProvider>(create: (context) => ListProvider()),
        ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
        ChangeNotifierProvider<ResourceProvider>(create: (context) => ResourceProvider()),
        ChangeNotifierProvider<SingleUserProvider>(create: (context) => SingleUserProvider()),
        ChangeNotifierProvider<UserDataProvider>(create: (context) => UserDataProvider()),
        ChangeNotifierProvider<RegisterUserProvider>(create: (context) =>RegisterUserProvider()),
        ChangeNotifierProvider<DeleteUserProvider>(create: (context) =>DeleteUserProvider()),
       
      //ChangeNotifierProvider<ThemeProvider>(
      //    create: (context) => ThemeProvider())
      ],
      builder: (context, child) {
        return  const MyApp();
      })
      ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      // meditateSize: Responsive.isMobile(context)
        //     ? const Size(375, 812)
        //     : const Size(1101, 640),
        minTextAdapt: true,
        splitScreenMode: true,
        child:
        MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'Sketch'.tr(),
        theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
     initialRoute: RouteName.login,
     onGenerateRoute: Routes.generateRoute,
      routes: {
          home_page.routeName: (context) => home_page(),
          SignupScreen.routeName: (context) => SignupScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),

          
         
          },
    ));
    
    
  }
}

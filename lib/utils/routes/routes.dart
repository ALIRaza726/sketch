import 'package:flutter/material.dart';
import 'package:sketch/screen/home_page.dart';
import 'package:sketch/screen/login_real.dart';
import 'package:sketch/utils/routes/route_name.dart';

class Routes{
  static Route<dynamic>  generateRoute(RouteSettings setting){
    switch(setting.name){
      case RouteName.home:
      return MaterialPageRoute(builder: (BuildContext context) => const home_page());
      case RouteName.login:
      return MaterialPageRoute(builder: (BuildContext context) => const LoginReal());

      default:
      return MaterialPageRoute(builder:(_){
return const Scaffold(
  body: Center(
    child: Text('No Route Defined'),
  ),
);
      });
    }
  }
}
import 'package:sketch/screen/app_bar.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:sketch/screen/home_page.dart';
import 'package:sketch/screen/page_scroll(link).dart';
import 'package:sketch/screen/sign_up.dart';
import 'package:sketch/screen/wel_come.dart';

void main() => runApp(const bottombar());

class bottombar extends StatelessWidget {
  static const routeName = '/MyApp';
  const bottombar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'sketch',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const Directionality(
        // use this property to change direction in whole app
        // CircularBottomNavigation will act accordingly
        textDirection: TextDirection.ltr,
        child: MyHomePage(title: 'sketch'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    this.title,
  }) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedPos = 0;

  double bottomNavBarHeight = 45;

  List<TabItem> tabItems = List.of([
    TabItem(
      Icons.home,
      "Home",
      const Color.fromARGB(255, 139, 187, 225),
      labelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
      ),
    ),
    TabItem(
      circleStrokeColor: const Color.fromARGB(255, 247, 24, 24),
      Icons.account_circle_outlined,
      "Login",
      const Color.fromARGB(255, 68, 224, 200),
      labelStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    TabItem(
      Icons.sports_handball_rounded,
      "Wellcome",
      const Color.fromARGB(255, 200, 130, 213),
      circleStrokeColor: Colors.black,
    ),
    TabItem(
      circleStrokeColor: const Color.fromARGB(255, 29, 65, 245),
      Icons.add_reaction_outlined,
      "SignUp",
      const Color.fromARGB(255, 245, 232, 59),
    ),
  ]);

  late CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          [
            const home_page(),
            // const LoginScreen(),
            const PageScroll(),
            const wel_come(),
            const signup(),
          ][selectedPos],
          Align(alignment: Alignment.bottomCenter, child: bottomNav())
        ],
      ),
    );
  }

  Widget bodyContainer() {
    Color? selectedColor = tabItems[selectedPos].circleColor;
    String slogan;
    switch (selectedPos) {
      case 0:
        slogan = "Family, Happiness, Food";
        break;
      case 1:
        slogan = "Find, Check, Use";
        break;
      case 2:
        slogan = "Receive, Review, Rip";
        break;
      case 3:
        slogan = "Noise, Panic, Ignore";
        break;
      default:
        slogan = "";
        break;
    }

    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: selectedColor,
        child: Center(
          child: Text(
            slogan,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      onTap: () {
        if (_navigationController.value == tabItems.length - 1) {
          _navigationController.value = 0;
        } else {
          _navigationController.value = _navigationController.value! + 1;
        }
      },
    );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      selectedPos: selectedPos,
      barHeight: bottomNavBarHeight,
      // use either barBackgroundColor or barBackgroundGradient to have a gradient on bar background
      // barBackgroundColor: Colors.white,
      barBackgroundGradient: const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Color.fromARGB(255, 44, 231, 234),
          Color.fromRGBO(135, 143, 234, 1),
        ],
      ),
      backgroundBoxShadow: const <BoxShadow>[
        BoxShadow(color: Color.fromARGB(115, 244, 4, 4), blurRadius: 10.0),
      ],
      animationDuration: const Duration(milliseconds: 900),
      selectedCallback: (int? selectedPos) {
        setState(() {
          this.selectedPos = selectedPos ?? 0;
          print("Index value:  >> ${_navigationController.value}");
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}

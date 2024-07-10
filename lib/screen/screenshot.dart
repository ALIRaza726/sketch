import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class ScreenShot extends StatefulWidget {
  const ScreenShot({super.key});

  @override
  State<ScreenShot> createState() => _ScreenShotState();
}

class _ScreenShotState extends State<ScreenShot> {
 void disableScreenshots() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  void enableScreenshots() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  }
void keepscreenOn()async{
await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_KEEP_SCREEN_ON);
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    disableScreenshots();
    keepscreenOn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Disable/Enable ScreenShots'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: enableScreenshots,
                  child: Text('Enable ScreenShot')),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: disableScreenshots,
                  child: Text('Disable ScreenShot')),
                    SizedBox(
                height: 20,
              ),
                   ElevatedButton(
                  onPressed: keepscreenOn,
                  child: Text('Screen On')),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}

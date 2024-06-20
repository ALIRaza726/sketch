import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class PopUp extends StatelessWidget {
  const PopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
body: Center(
  child:  ElevatedButton(
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  dialogBackgroundColor: Color.fromARGB(255, 173, 215, 233),
                  barrierColor: Color.fromARGB(255, 149, 238, 250),
                  dialogType: DialogType.info,
                  headerAnimationLoop: true,
                  animType: AnimType.bottomSlide,
                  title: 'INFO Reversed',
                  reverseBtnOrder: true,
                  btnOkOnPress: () {},
                  btnCancelOnPress: () {},
                  desc: ' Add TextFormField + Any Widjet,',
                ).show();
              },
              child: const Text(
                'PopUp (With Package)',
                style: TextStyle(
                    color: Color.fromARGB(255, 14, 14, 14), fontSize: 14),
              ),
            ),
),
    );
  }
}
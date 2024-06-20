import 'package:flutter/material.dart';

class checkBox extends StatefulWidget {
  const checkBox({super.key});

  @override
  State<checkBox> createState() => _checkBoxState();
}

class _checkBoxState extends State<checkBox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Checkbox(
                      fillColor: const MaterialStatePropertyAll(
                          Color.fromARGB(255, 146, 236, 149)),
                      checkColor: Color.fromARGB(255, 222, 29, 29),
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      }),
                      Text(isChecked ? 'Checked' : 'NotChecked'),
            ],
          ),
        ),
      ),
    );
  }
}
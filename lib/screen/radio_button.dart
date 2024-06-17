import 'package:flutter/material.dart';

class radio_button extends StatefulWidget {
  const radio_button({super.key});

  @override
  State<radio_button> createState() => _radio_buttonState();
}

class _radio_buttonState extends State<radio_button> {

   String selectedOption = "Radio Button 1";
  String selectedRadioOption = "Radio Button 1";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
              leading: Radio(
                  value: "1",
                 groupValue: selectedOption,
                  onChanged: (String? value) {
                    setState(() {
                      selectedOption = value!;
                    });
                  }),
              title: Text('Radio Button 1'),
            ),
            ListTile(
              leading: Radio(
                  value: "2",
                  groupValue: selectedOption,
                  onChanged: (String? value) {
                    setState(() {
                      selectedOption = value!;
                    });
                  }),
              title: Text('Radio Button 2'),
            ),
            ListTile(
              leading: Radio(
                value: "1",
                groupValue: selectedRadioOption,
                onChanged: (String? value) {
                  setState(() {
                    selectedOption = value!;
                  });
                },
              ),
              title: Text('Selected Radio Option'),
            ),
            ListTile(
              leading: Radio(
                value: "2",
                groupValue: selectedRadioOption,
                onChanged: (String? value) {
                  setState(() {
                    selectedOption = value!;
                  });
                },
              ),
              title: Text('Selected Radio Option'),
            ),
            
        ],
      ),
    ),
    );
  }
}
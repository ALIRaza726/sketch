import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  const RadioButton({super.key});

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  String selectedOption = "Radio Button 1";
  String selectedRadioOption = "Radio Button 1";
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                value: "3",
                groupValue: selectedOption,
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
                value: "4",
                groupValue: selectedOption,
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
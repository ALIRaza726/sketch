import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sketch/screen/tabs_stepper.dart';

class Stepper_Class extends StatefulWidget {
  const Stepper_Class({super.key});

  @override
  State<Stepper_Class> createState() => _Stepper_ClassState();
}
int _currentStep = 0;
class _Stepper_ClassState extends State<Stepper_Class> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _studyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Text('Stepper Example'),
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepTapped: (step) {
          setState(() {
            _currentStep = step;
          });
        },
        onStepContinue: () {
          
          if (_currentStep < 2) {
            setState(() {
              _currentStep += 1;
            });
          }
      
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
        steps: [
          Step(
            state: _currentStep <= 0 ? StepState.indexed : StepState.complete,
            title: Text('Personal info'),
            content: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Enter your name'),
                  controller: _nameController,
                ),
                // TextFormField(
                //   decoration: InputDecoration(labelText: 'Enter your email'),
                // ),
              ],
            ),
            isActive: _currentStep >= 0,
          ),
          
          Step(
            state: _currentStep <= 1 ? StepState.indexed : StepState.complete,
            title: Text('educational info'),
            content: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Enter your Qualification'),
                  controller: _studyController,
                ),
                // TextFormField(
                //   decoration:
                //       InputDecoration(labelText: 'Enter your phone number'),
                // ),
              ],
            ),
            isActive: _currentStep >= 1,
          ),
          // Step(
          //   state: _currentStep <= 2 ? StepState.indexed : StepState.complete,
          //   title: Text(''),
          //   content: Column(
          //     children: <Widget>[
          //       TextFormField(
          //         decoration: InputDecoration(labelText: 'Enter your address'),
          //       ),
          //       TextFormField(
          //         decoration:
          //             InputDecoration(labelText: 'Enter your phone number'),
          //       ),
          //     ],
          //   ),
          //   isActive: _currentStep >= 2,
          // ),
          Step(
            state: _currentStep <= 2 ? StepState.indexed : StepState.complete,
            title: Text('Submission'),
            content: Column(
              children: <Widget>[
                Text('Review your information'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Submit action
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        tabs_stepper(personal:_nameController.text,study: _studyController.text,),
                  ),
                );
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
            isActive: _currentStep >= 2,
          ),
        ],
      ),
    );
  
  }
}
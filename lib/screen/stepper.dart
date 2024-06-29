import 'package:flutter/material.dart';

class Stepper_Class extends StatefulWidget {
  const Stepper_Class({super.key});

  @override
  State<Stepper_Class> createState() => _Stepper_ClassState();
}
int _currentStep = 2;
class _Stepper_ClassState extends State<Stepper_Class> {
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
          
          if (_currentStep < 3) {
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
            title: Text('ok'),
            content: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Enter your name'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Enter your email'),
                ),
              ],
            ),
            isActive: _currentStep >= 0,
          ),
          
          Step(
            state: _currentStep <= 1 ? StepState.indexed : StepState.complete,
            title: Text(''),
            content: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Enter your address'),
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Enter your phone number'),
                ),
              ],
            ),
            isActive: _currentStep >= 1,
          ),
          Step(
            state: _currentStep <= 2 ? StepState.indexed : StepState.complete,
            title: Text('educational info'),
            content: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Enter your address'),
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Enter your phone number'),
                ),
              ],
            ),
            isActive: _currentStep >= 2,
          ),
          Step(
            state: _currentStep <= 3 ? StepState.indexed : StepState.complete,
            title: Text('personl; information'),
            content: Column(
              children: <Widget>[
                Text('Review your information'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Submit action
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
            isActive: _currentStep >= 3,
          ),
        ],
      ),
    );
  
  }
}
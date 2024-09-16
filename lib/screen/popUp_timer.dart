import 'dart:async';

import 'package:flutter/material.dart';

class PopUpTimer extends StatefulWidget {
  const PopUpTimer({super.key});

  @override
  State<PopUpTimer> createState() => _PopUpTimerState();
  
}

class _PopUpTimerState extends State<PopUpTimer> {
  static Timer? _popupTimer;
  // Show password dialog
static Future<void> showPasswordDialog(BuildContext context) async {
  TextEditingController passwordController = TextEditingController();
  
  // Automatically close after given seconds of inactivity
  _startPopupTimeout(context, duration: const Duration(seconds: 5));

  showGeneralDialog(
    context: context,
    barrierDismissible: false, // Prevent dismissal by tapping outside the dialog
    barrierColor: Colors.black.withOpacity(0.5), // Background color
    transitionDuration: const Duration(milliseconds: 900),
    pageBuilder: (context, anim1, anim2) {
      return const SizedBox.shrink();
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return FadeTransition(
        opacity: anim1,
        child: AlertDialog(
          title: const Text('Enter Password'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5, // Increase width
            child: TextField(
              autofocus: true,
              controller: passwordController,
              obscureText: true, // Hide password
              decoration: const InputDecoration(
                hintText: 'Enter password',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              ),
              onChanged: (value) {
                _resetPopupTimeout(context, duration: const Duration(seconds: 5)); // Reset timer on typing
              },
             
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
               Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}

// Timer to automatically close popups after a specified duration
static void _startPopupTimeout(BuildContext context, {required Duration duration}) {
  _popupTimer?.cancel(); // Cancel any existing timer
  _popupTimer = Timer(duration, () {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop(); // Automatically close the popup
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Popup closed due to inactivity')),
      );
    }
  });
}

// Reset the popup timeout
static void _resetPopupTimeout(BuildContext context, {required Duration duration}) {
  _popupTimer?.cancel(); // Cancel the current timer
  _startPopupTimeout(context, duration: duration); // Restart the timer with the same duration
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(child: ElevatedButton(onPressed: ()=> showPasswordDialog(context), child: Text('PopUP Timer'))),
    );
  }
}

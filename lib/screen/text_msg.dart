
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  // WhatsApp open karne ke liye function
  void _openWhatsApp() async {
    final String phoneNumber = '03096932971'; // Replace with your phone number
    final String message =
        'Hello! This is a text message.'; // Replace with your message
    final String url =
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Generic SMS app open karne ke liye function
  void _openSMSApp() async {
    final String phoneNumber = '1234567890'; // Replace with your phone number
    final String message =
        'Hello! This is a test message.'; // Replace with your message
    final String url = 'sms:$phoneNumber?body=${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Open Messaging App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _openWhatsApp,
              child: Text('Open WhatsApp'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openSMSApp,
              child: Text('Open SMS App'),
            ),
          ],
        ),
      ),
    );
  }
}

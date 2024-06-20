import 'package:flutter/material.dart';
import 'package:sketch/screen/e_mail.dart';

class SendMail extends StatefulWidget {
  const SendMail({super.key});

  @override
  State<SendMail> createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => e_mail()));
                },
                icon: const Icon(Icons.mail)),
      ),
    );
  }
}
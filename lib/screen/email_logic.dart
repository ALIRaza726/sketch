import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailSendScreen extends StatelessWidget {
  final String email;

  const EmailSendScreen({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Email'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final Uri emailLaunchUri = Uri(
              scheme: 'mailto',
              path: email,
            );

            _launchURL(emailLaunchUri, context);
          },
          child: Text('Send Email to $email'),
        ),
      ),
    );
  }

  void _launchURL(Uri url, BuildContext context) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not launch email client. Please make sure you have an email client installed.',
          ),
        ),
      );
    }
  }
}

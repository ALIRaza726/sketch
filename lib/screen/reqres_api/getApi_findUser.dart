
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FindUserScreen extends StatefulWidget {
  @override
  State<FindUserScreen> createState() => _FindUserScreenState();
}

class  _FindUserScreenState extends State<FindUserScreen> {
  bool _isLoading = false;
  String _userData = '';

  Future<void> fetchUserData() async {
    setState(() {
      _isLoading = true;
      _userData = ''; // Clear previous data
    });

    var headers = {
      'Accept': 'application/json',
      // 'Authorization':
      //     'Bearer YOUR_ACCESS_TOKEN_HERE', // Replace with your actual token
    };

    var request =
        http.Request('GET', Uri.parse('https://reqres.in/api/users/2'))
          ..headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // Convert response stream to a string
        String responseBody = await response.stream.bytesToString();

        // Parse the JSON response
        final data = json.decode(responseBody);
        setState(() {
          _userData = json.encode(data); // Store the data as a string
        });
      } else {
        setState(() {
          _userData = 'Error: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _userData = 'Exception: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              CircularProgressIndicator(), // Show loading indicator
            if (!_isLoading && _userData.isNotEmpty)
              Text(_userData), // Display user data
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchUserData,
              child: Text('Fetch User Data'),
            ),
          ],
        ),
      ),
    );
  }
}

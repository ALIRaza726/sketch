import 'package:flutter/material.dart';
import 'package:sketch/models/getApi_singleUser.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  SingleuserApi? _userApi;
  bool _isLoading = false;
  

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userApi = await fetchUser();
      setState(() {
        _userApi = userApi;
      });
    } catch (e) {
      // Handle errors here
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (_userApi != null && _userApi!.data != null)? AppBar(title:Text('${_userApi!.data!.firstName}'))
      : AppBar(title:Text('User Info')),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading) CircularProgressIndicator(),
              if (_userApi != null && _userApi!.data != null) ...[
                Image.network(_userApi!.data!.avatar!),
                Text('ID: ${_userApi!.data!.id}'),
                Text('Email: ${_userApi!.data!.email}'),
                Text('First Name: ${_userApi!.data!.firstName}'),
                Text('Last Name: ${_userApi!.data!.lastName}'),
              ] else if (!_isLoading) ...[
                Text('No data available.'),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _fetchData,
                child: Text('Fetch Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
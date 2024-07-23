import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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
                 _isLoading
                ? Shimmer.fromColors(
                    baseColor: Color.fromARGB(255, 163, 157, 157)!,
                    highlightColor: Color.fromARGB(255, 201, 199, 203)!,
                    child: Container(
                      width: 150.0,
                      height: 150.0,
                      color: Color.fromARGB(255, 50, 110, 43),
                    ),
                  )
                : _userApi!.data!.avatar != null
                    ? Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(_userApi!.data!.avatar!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                          : Container(
                        width: double.infinity,
                        height: 200.0,
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.image,
                          size: 100,
                          color: Colors.grey[600],
                        ),
                      ),
               // Image.network(_userApi!.data!.avatar!),
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
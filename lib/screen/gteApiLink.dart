import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sketch/models/getApiLink_model.dart';
import 'package:sketch/screen/getApiLink_UserDetail.dart';
import 'package:http/http.dart' as http;
class getApiLink extends StatefulWidget {
  const getApiLink({super.key});

  @override
  State<getApiLink> createState() => _getApiLinkState();
}

class _getApiLinkState extends State<getApiLink> {
 List<Datum> users = [];
  int currentPage = 1;
  int totalPages = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchData(currentPage);
  }

  Future<void> _fetchData(int page) async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    // try {
      final response =
          await http.get(Uri.parse('https://reqres.in/api/users?page=$page'));

      if (response.statusCode == 200) {
        UserGetApi userGetApi = UserGetApi.fromMap(json.decode(response.body));
        setState(() {
          users = userGetApi.data;
          currentPage = page;
          totalPages = userGetApi.totalPages;
        });
      } else {
        throw Exception('Failed to load users');
      }
       setState(() {
        isLoading = false;
      });
    // } catch (error) {
    //   // Handle the error here if necessary
    // } finally {
    //   setState(() {
    //     isLoading = false;
    //   });
    // }
  }

  List<Widget> _buildPageNumbers() {
    List<Widget> pageNumbers = [];
    for (int i = 1; i <= totalPages; i++) {
      pageNumbers.add(
        ElevatedButton(
          onPressed: () => _fetchData(i),
          child: Text('$i'),
          style: ElevatedButton.styleFrom(
            backgroundColor: i == currentPage ? Colors.blue : const Color.fromARGB(255, 184, 182, 182),
          ),
        ),
      );
    }
    return pageNumbers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (users.isEmpty && isLoading)
              ElevatedButton(
                onPressed: () => _fetchData(currentPage),
                child: const Text('Fetch Users'),
              ),
            if (isLoading) CircularProgressIndicator(),
            if (users.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(users[index].avatar),
                      ),
                      title: Text(
                          '${users[index].firstName} ${users[index].lastName}'),
                      subtitle: Text(users[index].email),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UserDetailScreen(user: users[index]),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            if (users.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageNumbers(),
              ),
          ],
        ),
      ),
    );
  }
}
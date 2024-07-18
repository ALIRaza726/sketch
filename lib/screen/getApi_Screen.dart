import 'package:flutter/material.dart';
import 'package:sketch/helpers/getapi_response.dart';
import 'package:sketch/models/getApi_model.dart';

class GetApiScreen extends StatefulWidget {
  const GetApiScreen({super.key});

  @override
  State<GetApiScreen> createState() => _GetApiScreenState();
}

class _GetApiScreenState extends State<GetApiScreen> {
 Future<UserGetApi>? futureUsers;

  void _fetchData() {
    setState(() {
      futureUsers = fetchUsers();
    });
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
            ElevatedButton(
              onPressed: _fetchData,
              child: const Text('Fetch Users'),
            ),
            const SizedBox(height: 20),
            futureUsers == null
                ? const Text('Press the button to fetch users')
                : FutureBuilder<UserGetApi>(
                    future: futureUsers,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        List<Datum> users = snapshot.data!.data;
                        return Expanded(
                          child: ListView.builder(
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(users[index].avatar),
                                ),
                                title: Text(
                                    '${users[index].firstName} ${users[index].lastName}'),
                                subtitle: Text(users[index].email),
                                trailing:  Text(
                                    '${users[index].id}') ,
                              );
                            },
                          ),
                        );
                      } else {
                        return const Text('No data found');
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
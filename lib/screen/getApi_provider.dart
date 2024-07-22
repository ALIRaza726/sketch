import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sketch/helpers/getAPi_Provider_class.dart';
import 'package:sketch/models/getApiModel_provider.dart';

class VideoCallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (userProvider.users.isEmpty && !userProvider.isLoading)
              ElevatedButton(
                onPressed: () => userProvider.fetchData(userProvider.currentPage),
                child: const Text('Fetch Users'),
              ),
            if (userProvider.isLoading) CircularProgressIndicator(),
            if (userProvider.users.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: userProvider.users.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(userProvider.users[index].avatar),
                      ),
                      title: Text(
                          '${userProvider.users[index].firstName} ${userProvider.users[index].lastName}'),
                      subtitle: Text(userProvider.users[index].email),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetailScreen(user: userProvider.users[index]),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            if (userProvider.users.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(userProvider.totalPages, (index) {
                  return ElevatedButton(
                    onPressed: () => userProvider.fetchData(index + 1),
                    child: Text('${index + 1}'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: index + 1 == userProvider.currentPage ? Colors.blue : Colors.grey,
                    ),
                  );
                }),
              ),
          ],
        ),
      ),
    );
  }
}

class UserDetailScreen extends StatelessWidget {
  final Datum user;

  const UserDetailScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.firstName} ${user.lastName}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.avatar),
              radius: 50,
            ),
            const SizedBox(height: 20),
            Text(
              '${user.firstName} ${user.lastName}',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            Text(user.email, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
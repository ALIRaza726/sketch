import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sketch/models/ResourceApiModel.dart';
import '../helpers/ResourceProvider.dart';

class ResourceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<ResourceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resources List'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!userProvider.isLoading && userProvider.resources.isEmpty)
              ElevatedButton(
                onPressed: () => userProvider.fetchResources(),
                child: const Text('Fetch Resources'),
              ),
            if (userProvider.isLoading) CircularProgressIndicator(), 
            if (userProvider.resources.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: userProvider.resources.length,
                  itemBuilder: (context, index) {
                    final resource = userProvider.resources[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(int.parse("0xff${resource.color.substring(1)}")),
                      ),
                      title: Text(resource.name),
                      subtitle: Text('Year: ${resource.year}\nPantone: ${resource.pantoneValue}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResourceDetailScreen(resource: resource),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ResourceDetailScreen extends StatelessWidget {
  final ResourceData resource;

  const ResourceDetailScreen({Key? key, required this.resource}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(resource.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Color(int.parse("0xff${resource.color.substring(1)}")),
              radius: 50,
            ),
            const SizedBox(height: 20),
            Text(
              resource.name,
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            Text('Year: ${resource.year}', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Pantone: ${resource.pantoneValue}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
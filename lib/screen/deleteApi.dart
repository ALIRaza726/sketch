import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class DeleteUser extends StatefulWidget {
  const DeleteUser({super.key});

  @override
  State<DeleteUser> createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {
  final _userIdController = TextEditingController();
  bool _isLoading = false;

  void _deleteUser() async {
    if (_userIdController.text.isEmpty ||
        int.tryParse(_userIdController.text) == null) {
      // setState(() {
      //   _isLoading = false;
      // });
      _showError("Please enter a valid user ID.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final provider = Provider.of<DeleteUserProvider>(context, listen: false);
    await provider.deleteUser(int.parse(_userIdController.text));

    setState(() {
      _isLoading = false;
    });
  }

  void _showError(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DeleteUserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Delete User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _userIdController,
                decoration: const InputDecoration(labelText: 'User ID'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              if (_isLoading) const CircularProgressIndicator(),
              if (provider.message != null) ...[
                const SizedBox(height: 20),
                Text(provider.message!),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _deleteUser,
                child: const Text('Delete User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteUserProvider with ChangeNotifier {
  String? _message;

  String? get message => _message;

  Future<void> deleteUser(int userId) async {
    var url = Uri.parse(
        'https://reqres.in/api/users/$userId'); // Adjust your API URL as needed

    try {
      final response = await http.delete(url);

      if (response.statusCode == 204) {
        _message = "User deleted successfully!";
      } else if (response.statusCode == 404) {
        _message = "User not found!";
      } else {
        _message = "Failed to delete user. Please check the user ID.";
      }
    } catch (e) {
      _message = "Error: $e";
    }

    notifyListeners();
  }
}
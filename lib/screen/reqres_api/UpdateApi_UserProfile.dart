import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sketch/helpers/UpdateApi_UserProfile.dart';

class UserProfileForm extends StatefulWidget {
  const UserProfileForm({super.key});

  @override
  _UserProfileFormState createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    final userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    _emailController =
        TextEditingController(text: userDataProvider.user?.email);
    _firstNameController =
        TextEditingController(text: userDataProvider.user?.firstName);
    _lastNameController =
        TextEditingController(text: userDataProvider.user?.lastName);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(userDataProvider.user?.avatar ??
                    'https://reqres.in/img/faces/2-image.jpg'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await userDataProvider.updateUserData(
                      _emailController.text,
                      _firstNameController.text,
                      _lastNameController.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('User data updated successfully!')));
                  }
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


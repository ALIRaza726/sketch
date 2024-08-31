import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';


class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
    File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

 

  Future<http.Response> savePostNow() async {
    final String title = _titleController.text;
    final int categoryId = int.parse(_categoryIdController.text);
    final String author = _authorController.text;
    final String desc = _descController.text;
    final String imagedata=_imageFile.toString();

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3Rlc3QudGhlcG9zZ2VuaWVlLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MjQ5NTAyMTUsImV4cCI6MTcyNDk1MzgxNSwibmJmIjoxNzI0OTUwMjE1LCJqdGkiOiIzb3NXTk9ESHlpZnl4MzdVIiwic3ViIjoiNSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.3ol1c32XQUOmwVZdZm4WqTP40uTJjkTk0Em2K8eEYQQ'
    };
    var request = http.Request(
        'POST', Uri.parse('https://test.theposgeniee.com/api/savedata'));
    request.headers.addAll(headers);
    request.body = json.encode({
      "tittle": title,
      "category_id": categoryId,
      "author": author,
      "desc": desc,
      "image": imagedata
    });
    http.StreamedResponse response = await request.send();
    return await http.Response.fromStream(response);
  }

  void _showMessage(String message, Color color) {
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
void clear(){
   _descController.clear();
    _authorController.clear();
    _categoryIdController.clear();
    _titleController.clear();
    _imageFile?.delete();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _categoryIdController,
                decoration: InputDecoration(labelText: 'Category ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category ID';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(labelText: 'Author'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an author name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
                SizedBox(height: 10),
                _imageFile != null
                ? Image.file(
                    _imageFile!,
                    height: 150,
                  )
                : Text('No image selected.'),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() && _imageFile != null) {
                    var response = await savePostNow();
                    if (response.statusCode == 200 ) {
                      _showMessage('Post created successfully!', Colors.green);
                     clear();
                    }
                     else {
                      _showMessage('Failed to create post.', Colors.red);
                      
                    }
                  }
                  else{ _showMessage('Piease select image.', Colors.red);}
                },
                child: Text('Create Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
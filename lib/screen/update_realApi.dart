import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// MODEL 
class Post {
  int? id;
  String? tittle;
  int? categoryId;
  dynamic photo;
  String? author;
  String? desc;
  DateTime? createdAt;
  DateTime? updatedAt;

  Post({
    this.id,
    this.tittle,
    this.categoryId,
    this.photo,
    this.author,
    this.desc,
    this.createdAt,
    this.updatedAt,
  });

  factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"] ?? 0,
        tittle: json["tittle"] ?? "",
        categoryId: json["category_id"] ?? 0,
        photo: json["photo"] == null ? null : json["photo"],
        author: json["author"] ?? "",
        desc: json["desc"] ?? "",
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tittle": tittle,
        "category_id": categoryId,
        "photo": photo,
        "author": author,
        "desc": desc,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class UpdateRealApi extends StatefulWidget {
  @override
  UpdateRealApiState createState() => UpdateRealApiState();
}

class UpdateRealApiState extends State<UpdateRealApi> {
  List<Post> _posts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  // Function to get api
  Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse('https://test.theposgeniee.com/api/getallposts'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      setState(() {
        _posts = jsonResponse.map((post) => Post.fromJson(post)).toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load posts')),
      );
    }
  }

  // Function to update a post
  Future updatePost(Post post) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3Rlc3QudGhlcG9zZ2VuaWVlLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MjQ5NTAyMTUsImV4cCI6MTcyNDk1MzgxNSwibmJmIjoxNzI0OTUwMjE1LCJqdGkiOiIzb3NXTk9ESHlpZnl4MzdVIiwic3ViIjoiNSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.3ol1c32XQUOmwVZdZm4WqTP40uTJjkTk0Em2K8eEYQQ'
    };
     var request = http.Request(
        'POST', Uri.parse('https://test.theposgeniee.com/api/updatedata/${post.id}'));
    request.headers.addAll(headers);
    request.body = json.encode({
      "tittle": post.tittle,
      "author": post.author,
      "desc": post.desc,
      
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
    // final response = await http.put(
    //   Uri.parse('https://test.theposgeniee.com/api/updatedata/${post.id}'),
    //   // headers: {
         

    //   //   // HttpHeaders.contentTypeHeader: 'application/json',
    //   // },
      
      
    //   body: post.toRawJson(),
    // );
    

    // if (response.statusCode == 200) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Post updated successfully')),
    //   );
    //   fetchPosts(); // Refresh the list after updating
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Failed to update post')),
    //   );
    // }
  

  // Function to show update dialog
  void _showUpdateDialog(Post post) {
    TextEditingController titleController = TextEditingController(text: post.tittle);
    TextEditingController descController = TextEditingController(text: post.desc);
    TextEditingController authorController = TextEditingController(text: post.author);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: authorController,
                decoration: InputDecoration(labelText: 'Author'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              
              onPressed: () async{
                
                var response = await updatePost(post);
                 if (response.statusCode == 200 ) {
                      _showMessage('Post created successfully!', Colors.green);
                      _isLoading = false;
                     
                    }
                    else {
                      _showMessage('Failed to create post.', Colors.red);
                      
                    }
                // Update post object with new data
                post.tittle = titleController.text;
                post.desc = descController.text;
                post.author = authorController.text;
                

                setState(() {
                 
                  updatePost(post);
                });
               
                Navigator.of(context).pop();
               
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Posts'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _posts.isEmpty
              ? Center(child: Text('No posts available'))
              : ListView.builder(
                  itemCount: _posts.length,
                  itemBuilder: (context, index) {
                    final post = _posts[index];
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: post.photo != null
                            ? Image.network(post.photo, width: 50, height: 50, fit: BoxFit.cover)
                            : Icon(Icons.image_not_supported),
                        title: Text(post.tittle ?? 'No Title'),
                        subtitle: Text(post.desc ?? 'No Description'),
                        onTap: () {
                          _showUpdateDialog(post);
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
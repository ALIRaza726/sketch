import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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

class SearchApi extends StatefulWidget {
  @override
  SearchApiState createState() => SearchApiState();
}

class SearchApiState extends State<SearchApi> {
  List<Post> _posts = [];
  bool _isLoading = true;
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  // Fetch posts from API
  Future<void> fetchPosts() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse(
        'https://test.theposgeniee.com/api/getallposts?search=$searchQuery'));

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
        const SnackBar(content: Text('Failed to load posts')),
      );
    }
  }

  // Delete a post
  Future<void> deletePost(int id) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var request = http.Request(
      'POST',
      Uri.parse('https://test.theposgeniee.com/api/deletedata/$id'),
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final httpResponse = await http.Response.fromStream(response);

    if (httpResponse.statusCode == 200) {
      final jsonResponse = json.decode(httpResponse.body);
      if (jsonResponse['success'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post deleted successfully')),
        );
        fetchPosts(); // Refresh the list after deleting
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete post')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete post')),
      );
    }
  }

  // Show delete confirmation dialog
  void _showDeleteDialog(Post post) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this post?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                deletePost(post.id!); // Call the delete function
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // Show update dialog
  void _showUpdateDialog(Post post) {
    TextEditingController titleController =
        TextEditingController(text: post.tittle);
    TextEditingController descController =
        TextEditingController(text: post.desc);
    TextEditingController authorController =
        TextEditingController(text: post.author);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: authorController,
                decoration: const InputDecoration(labelText: 'Author'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                var response = await updatePost(post);
                if (response.statusCode == 200) {
                  _showMessage('Post updated successfully!', Colors.green);
                } else {
                  _showMessage('Failed to update post.', Colors.red);
                }

                setState(() {
                 
                  post.tittle = titleController.text;
                  post.desc = descController.text;
                  post.author = authorController.text;
                 // Call function to update in database
                  updatePost(post);
                });

                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future updatePost(Post post) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3Rlc3QudGhlcG9zZ2VuaWVlLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MjU5MTAwNzMsImV4cCI6MTcyNTkxMzY3MywibmJmIjoxNzI1OTEwMDczLCJqdGkiOiJBakQwcDdXSVVtNDU3cHR6Iiwic3ViIjoiNiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.TM2xhdOlQblZf7tL9RDwRFe9KDQJjquxu4AOfTOT3Ag'
    };

    var request = http.Request(
      'POST',
      Uri.parse('https://test.theposgeniee.com/api/updatedata/${post.id}'),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Posts'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search by Title',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
                fetchPosts(); // Fetch posts based on search query
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _posts.isEmpty
                    ? const Center(child: Text('No posts available'))
                    : ListView.builder(
                        itemCount: _posts.length,
                        itemBuilder: (context, index) {
                          final post = _posts[index];
                          return Dismissible(
                            key: Key(post.id.toString()),
                            background:  Container(
                                color: Colors.green,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: Icon(Icons.edit,
                                            color: Colors.white)))),
                            secondaryBackground: Container(
                                color: Colors.red,
                                child: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                        padding: EdgeInsets.only(right: 20.0),
                                        child: Icon(Icons.delete,
                                            color: Colors.white)))),
                           
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.endToStart) {
                                // Show delete dialog
                                _showDeleteDialog(post);
                                return false;
                              } else if (direction ==
                                  DismissDirection.startToEnd) {
                                // Show update dialog
                                _showUpdateDialog(post);
                                return false;
                              }
                              return false;
                            },
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              child: ListTile(
                                leading: post.photo != null
                                    ? Image.network(post.photo,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover)
                                    : const Icon(Icons.image_not_supported),
                                title: Text(post.tittle ?? 'No Title'),
                                subtitle: Text(post.desc ?? 'No Description'),
                                onTap: () {
                                  _showUpdateDialog(post);
                                },
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
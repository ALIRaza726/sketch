import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
 // MODEL To get data from api
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
        id: json["id"]??0,
        tittle: json["tittle"]??"",
        categoryId: json["category_id"]??0,
        photo: json["photo"]==null ? null :json["photo"],
        author: json["author"]??"",
        desc: json["desc"]??"",
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

class GetPostApi extends StatefulWidget {
  @override
  _GetPostApiState createState() => _GetPostApiState();
}

class _GetPostApiState extends State<GetPostApi> {
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
// UI 
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
                          print("photo:${post.photo}");
                          // You can handle on tap event if needed
                        },
                        
                      ),
                      
                    );
                    
                  },
                ),
                
    );
  }
}


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';


class ImageUrl extends StatefulWidget {
  const ImageUrl({super.key});

  @override
  State<ImageUrl> createState() => _ImageUrlState();
}

class _ImageUrlState extends State<ImageUrl> {
  String? _imageUrl;
  bool _isLoading = false;
  String? _VideoUrl;

  Future<void> _openBrowser() async {
    const url = 'https://www.google.com/search?q=cars+wallpapers&tbm=isch';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _loadImage(String imageUrl) async {
    setState(() {
      _isLoading = true;
      _imageUrl = null;
      _VideoUrl = null;
    });

    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        setState(() {
          _imageUrl = imageUrl;
          _isLoading = false;
          _VideoUrl = imageUrl;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        throw 'Could not load image';
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      throw 'Could not load image';
    }
  }

  void _promptForImageUrl() async {
    final TextEditingController _urlController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Image URL'),
          content: TextField(
            controller: _urlController,
            decoration: InputDecoration(hintText: 'Enter the URL of the image'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _loadImage(_urlController.text);
              },
              child: Text('Load Image'),
            ),
          ],
        );
      },
    );
  }
  void _promptForImageUrlVideo() async {
    final TextEditingController _urlController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Image URL'),
          content: TextField(
            controller: _urlController,
            decoration: InputDecoration(hintText: 'Enter the URL of the image'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _loadImage(_urlController.text);
              },
              child: Text('Load Video'),
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
        title: Text('Shimmer Effect with Image Picker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _openBrowser,
              child: Text('Open Browser for Wallpapers'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: _promptForImageUrl,
              child: Text('Enter Image URL Manually'),
            ),
             ElevatedButton(
              onPressed: _promptForImageUrlVideo,
              child: Text('Enter Image URL Manually'),
            ),
            const SizedBox(height: 16.0),
            _isLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      height: 200.0,
                      color: Colors.white,
                    ),
                  )
                : _imageUrl != null
                    ? Container(
                        width: double.infinity,
                        height: 200.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(_imageUrl!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: 200.0,
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.image,
                          size: 100,
                          color: Color.fromARGB(255, 138, 165, 218),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
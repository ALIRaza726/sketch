import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ImageVideo extends StatefulWidget {
  const ImageVideo({super.key});

  @override
  State<ImageVideo> createState() => _ImageVideoState();
}
class _ImageVideoState extends State<ImageVideo> {
final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  XFile? _videoFile;
  VideoPlayerController? _videoController;

  Future<void> _pickImage(BuildContext context) async {
    final pickedFile = await showDialog<XFile>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context)
                  .pop(await _picker.pickImage(source: ImageSource.camera));
            },
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context)
                  .pop(await _picker.pickImage(source: ImageSource.gallery));
            },
            child: const Text('Gallery'),
          ),
        ],
      ),
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Future<void> _pickVideo(BuildContext context) async {
    final pickedFile = await showDialog<XFile>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Video Source'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context)
                  .pop(await _picker.pickVideo(source: ImageSource.camera));
            },
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context)
                  .pop(await _picker.pickVideo(source: ImageSource.gallery));
            },
            child: const Text('Gallery'),
          ),
        ],
      ),
    );

    if (pickedFile != null) {
      setState(() {
        _videoFile = pickedFile;
        _videoController = VideoPlayerController.file(File(_videoFile!.path))
          ..initialize().then((_) {
            setState(() {});
            _videoController!.play();
          });
      });
    }
  }

  @override
  void dispose() {
    
    _videoController?.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image and Video Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _pickImage(context),// call via pass parameter
              child: const Text('Pick Image'),
            ),
            if (_imageFile != null)
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Image.file(File(_imageFile!.path)),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () { _pickVideo(context);},// call via pass parameter
              child: const Text('Pick Video'),
            ),
            if (_videoController != null &&
                _videoController!.value.isInitialized)
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: VideoPlayer(_videoController!),
              ),
          ],
        ),
      ),
    );
  }
}

  
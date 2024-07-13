import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';



class ImageSaveToGallery extends StatelessWidget {
  static const routeName = '/ImageSaveToGallery';
  const ImageSaveToGallery({Key? key}) : super(key: key);

  final String assetImagePath =
      'assets/images/laptop.png'; // Replace with your asset image path

  Future<void> downloadImage(BuildContext context) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final ByteData imageData = await rootBundle.load(assetImagePath);
      final Directory tempDir = await getTemporaryDirectory();
      final String tempPath = tempDir.path;
      final File tempFile = File('$tempPath/your_image.png');
      await tempFile.writeAsBytes(imageData.buffer
          .asUint8List(imageData.offsetInBytes, imageData.lengthInBytes));

      final Directory? appDocDir = await getExternalStorageDirectory();
      final String appDocPath = appDocDir!.path;
      final File permanentFile =
          await tempFile.copy('$appDocPath/download.png');

      await GallerySaver.saveImage(permanentFile.path).then((bool? success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image saved to gallery: ${permanentFile.path}'),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Permission denied'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Download to Gallery'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Image.asset(
            assetImagePath,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => downloadImage(context),
        child: const Icon(Icons.download),
      ),
    );
  }
}
  
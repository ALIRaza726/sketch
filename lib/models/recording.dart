import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class RecordingModel extends ChangeNotifier {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final List<String> _recordings = [];
  bool _isRecording = false;
  bool _isPlaying = true;
  String _filePath = '';

  List<String> get recording => _recordings;
  

 Future<void> _startRecording() async {
    final Directory tempDir = Directory.systemTemp;
   final String path =
         '${tempDir.path}/voice_record_${DateTime.now().millisecondsSinceEpoch}.aac';
    await _recorder.startRecorder(
      toFile: path,
      codec: Codec.aacADTS,
    );
    notifyListeners();
    // setState(() {
       _isRecording = true;
       _filePath = path;
    // });
  }

  void removeItem(String item) {
    _recordings.remove(item);
    notifyListeners();
  }
}

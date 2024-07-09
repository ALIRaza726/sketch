import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioDocx extends StatefulWidget {
  const AudioDocx({super.key});

  @override
  State<AudioDocx> createState() => _AudioDocxState();
}

class _AudioDocxState extends State<AudioDocx> {
 // List<String>_recordings=[];
  List<String> audioFiles = [];
  List<String> documentFiles = [];
  FlutterSoundPlayer? _audioPlayer;
  bool _isPlaying = false;
  String? _currentPlayingPath;
  bool _isRecording = false;
  final FlutterSoundPlayer _player = FlutterSoundPlayer();

  @override
  void initState() {
    super.initState();
    _audioPlayer = FlutterSoundPlayer();
    openAudioSession();
  }

  @override
  void dispose() {
    _audioPlayer?.closePlayer();
    _player.closePlayer();
    super.dispose();
  }

  Future<void> openAudioSession() async {
    await _audioPlayer?.openPlayer();
  }

  Future<void> requestPermissions() async {
    if (await Permission.storage.isDenied) {
      await Permission.storage.request();
    }

    if (await Permission.manageExternalStorage.isDenied) {
      await Permission.manageExternalStorage.request();
    }
  }
   Future<void> _stopPlayback() async {
    await _player.stopPlayer();
    setState(() {
      _isPlaying = false;
    });
  }
Future<void> _startPlayback(String path)  async {
    if (audioFiles.isNotEmpty)
              Column(
                children:await audioFiles.map((file) {
                  return ListTile(
                    title: Text(file.split('/').last),
                    trailing: IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () => playAudio(file),
                    ),
                  );
                }).toList(),
              );
  }
  Future<void> _deleteRecording(String path) async {
    if (_isPlaying && _currentPlayingPath == path) {
      await _stopPlayback();
    }
    File file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
    setState(() {
      audioFiles.remove(path);
    });
  }
 
  Future<void> pickAudioFiles() async {
    await requestPermissions();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        audioFiles = result.paths.map((path) => path!).toList();
      });
    }
  }

  Future<void> pickDocumentFiles() async {
    await requestPermissions();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        documentFiles = result.paths.map((path) => path!).toList();
      });
    }
  }

  Future<void> playAudio(String path) async {
    await _audioPlayer?.startPlayer(fromURI: path);
  }

  Future<void> openDocument(String path) async {
    await OpenFile.open(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Picker Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: pickAudioFiles,
              child: Text('Pick Audio Files'),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: audioFiles.length,
                itemBuilder: (context, index) {
                  String audio = audioFiles[index];
                  return ListTile(
                    title: Text('Audio ${index + 1}'),
                    subtitle: Text(audio),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _currentPlayingPath == audio && _isPlaying
                            ? IconButton(
                                icon: const Icon(Icons.stop),
                                onPressed: _stopPlayback,
                              )
                            : IconButton(
                                icon: const Icon(Icons.play_arrow),
                                onPressed: () => _startPlayback(audio),
                              ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteRecording(audio),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickDocumentFiles,
              child: Text('Pick Document Files'),
            ),
            if (documentFiles.isNotEmpty)
              Column(
                children: documentFiles.map((file) {
                  return ListTile(
                    title: Text(file.split('/').last),
                    trailing: IconButton(
                      icon: Icon(Icons.open_in_new),
                      onPressed: () => openDocument(file),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';


class SoundRecording extends StatefulWidget {
  const SoundRecording({super.key});

  @override
  State<SoundRecording> createState() => _SoundRecordingState();
}

class _SoundRecordingState extends State<SoundRecording> {
   final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isRecording = false;
  bool _isPlaying = true;
   String _filePath = '';
   final List<String> _recordings = [];
   String? _currentPlayingPath;

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
    _initializePlayer();
  }

  Future<void> _initializeRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await _recorder.openRecorder();
  }

  Future<void> _initializePlayer() async {
    await _player.openPlayer();
  }

  Future<void> _startRecording() async {
    final Directory tempDir = Directory.systemTemp;
   final String path =
         '${tempDir.path}/voice_record_${DateTime.now().millisecondsSinceEpoch}.aac';
    await _recorder.startRecorder(
      toFile: path,
      codec: Codec.aacADTS,
    );
    setState(() {
      _isRecording = true;
      _filePath = path;
    });
  }

 Future<void> _stopRecording() async {
    String? path = await _recorder.stopRecorder();
    if (path != null) {
      setState(() {
        _isRecording = false;
        _recordings.add(path);
      });
    }
  }

  Future<void> _startPlayback(String path) async {
    await _player.startPlayer(
      fromURI: path,
      codec: Codec.aacADTS,
      whenFinished: () {
        setState(() {
          _isPlaying = false;
          _currentPlayingPath = null;
        });
      },
    );
    setState(() {
      _isPlaying = true;
      _currentPlayingPath = path;
    });
  }

  Future<void> _stopPlayback() async {
    await _player.stopPlayer();
    setState(() {
      _isPlaying = false;
    });
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
      _recordings.remove(path);
    });
  }
  @override
  void dispose() {
    _recorder.closeRecorder();
    _player.closePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final recording1 = Provider.of<RecordingModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice Recorder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
            ),
               Expanded(
              child: ListView.builder(
                itemCount: _recordings.length,
                itemBuilder: (context, index) {
                  String recording = _recordings[index];
                  return ListTile(
                    title: Text('Recording ${index + 1}'),
                    subtitle: Text(recording),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _currentPlayingPath == recording && _isPlaying
                            ? IconButton(
                                icon: Icon(Icons.stop),
                                onPressed: _stopPlayback,
                              )
                            : IconButton(
                                icon: Icon(Icons.play_arrow),
                                onPressed: () => _startPlayback(recording),
                              ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteRecording(recording),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
         
          //   if (_filePath.isNotEmpty && !_isRecording)
          //     Column(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Text('Recorded file: $_filePath'),
          //         ),
          //         ElevatedButton(
          //           onPressed: _isPlaying ? _stopPlayback : _startPlayback,
          //           child:
          //               Text(_isPlaying ? 'Stop Playback' : 'Start Playback'),
          //         ),
          //       ],
          //     ),
          // ],
        ]),
      ),
    );
  }
}

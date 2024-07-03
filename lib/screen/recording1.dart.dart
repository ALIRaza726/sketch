import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class SoundRecording1 extends StatefulWidget {
  const SoundRecording1({super.key});

  @override
  State<SoundRecording1> createState() => _SoundRecordingState();
}

class _SoundRecordingState extends State<SoundRecording1> {
   final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isRecording = false;
  bool _isPlaying = false;
  String _filePath = '';

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
    final String path = '${tempDir.path}/voice_record.aac';
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
    await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
    });
  }

  Future<void> _startPlayback() async {
    await _player.startPlayer(
      fromURI: _filePath,
      codec: Codec.aacADTS,
      whenFinished: () {
        setState(() {
          _isPlaying = false;
        });
      },
    );
    setState(() {
      _isPlaying = true;
    });
  }

  Future<void> _stopPlayback() async {
    await _player.stopPlayer();
    setState(() {
      _isPlaying = false;
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
            if (_filePath.isNotEmpty && !_isRecording)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Recorded file: $_filePath'),
                  ),
                  ElevatedButton(
                    onPressed: _isPlaying ? _stopPlayback : _startPlayback,
                    child:
                        Text(_isPlaying ? 'Stop Playback' : 'Start Playback'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}


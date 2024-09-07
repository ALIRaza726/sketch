

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isRecording = false;
  bool _isPlaying = false;
  String _filePath = '';
  final List<String> _recordings = [];
  String? _currentPlayingPath;

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
    _initializePlayer();
    _loadRecordings();
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
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    var storageStatus = await Permission.storage.request();
    if (storageStatus != PermissionStatus.granted) {
      throw RecordingPermissionException('Storage permission not granted');
    }

    final Directory? appDocDir = await getExternalStorageDirectory();
    final String path =
        '${appDocDir?.path}/voice_record_${DateTime.now().millisecondsSinceEpoch}.aac';
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
        _saveRecordings();
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
      _saveRecordings();
    });
  }

  Future<void> _saveRecordings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('record', _recordings);
  }
 
  Future<void> _loadRecordings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _recordings.addAll(prefs.getStringList('record') ?? []);
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
            Row(
              children: [
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

  
  

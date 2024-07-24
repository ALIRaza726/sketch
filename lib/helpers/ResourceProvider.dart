import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sketch/models/ResourceApiModel.dart';


class ResourceProvider extends ChangeNotifier {
  List<ResourceData> _resources = [];
  bool _isLoading = false;

  List<ResourceData> get resources => _resources;
  bool get isLoading => _isLoading;

  Future<void> fetchResources() async {
  

   var request = http.Request('GET', Uri.parse('https://reqres.in/api/unknown'));

    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);
        ResourceApiModel resourceApiModel = ResourceApiModel.fromMap(data);
        _resources = resourceApiModel.data;
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
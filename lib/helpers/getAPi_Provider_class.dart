import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sketch/models/getApiModel_provider.dart';


class UserProvider extends ChangeNotifier {
  List<Datum> _users = [];
  int _currentPage = 1;
  int _totalPages = 1;
  bool _isLoading = false;

  List<Datum> get users => _users;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  bool get isLoading => _isLoading;

  Future<void> fetchData(int page) async {
   // if (_isLoading) return;

    _isLoading = true;
    notifyListeners();
  
    try {
      final response = await http.get(Uri.parse('https://reqres.in/api/users?page=$page'));

      if (response.statusCode == 200) {
        UserGetApi userGetApi = UserGetApi.fromMap(json.decode(response.body));
        _users = userGetApi.data;
        _currentPage = page;
        _totalPages = userGetApi.totalPages;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (error) {
      // Handle the error here if necessary
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
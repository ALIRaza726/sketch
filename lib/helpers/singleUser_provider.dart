// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:sketch/models/getApi_singleUser.dart';
// // import 'package:http/http.dart' as http;

// // class SingleUserProvider extends ChangeNotifier {
  
// //   String _email='';
// //   String _firstName='';
// //   String _lastName='';
// //   String _avatar='';
// //   bool _isLoading= false;
// //   Data? data;
  
// //   String get email => _email;
// //   String get firstName => _firstName;
// //   String get lastName => _lastName;
// //   String get avatar => _avatar;
// //   bool get isLoading => _isLoading;
// //   // Data get data;
  

// //    Future<SingleuserApi?> fetchUser() async {
// //       _isLoading = true;
// //       notifyListeners();

// //   var headers = {
// //     'Accept': 'application/json',
// //     'Authorization':
// //         'Bearer 59387|rVxTQUFzgeptn2NWBgcNxnO4exfHo880AJApBJEI49e733d9',
// //   };

// //   var request = http.Request('GET', Uri.parse('https://reqres.in/api/users/2'))
// //     ..headers.addAll(headers);

// //   try {
// //     http.StreamedResponse response = await request.send();

// //     if (response.statusCode == 200) {
// //       String responseBody = await response.stream.bytesToString();
// //       final data = json.decode(responseBody);
// //     
// //       return SingleuserApi.fromMap(data);
// //     } else {
// //       print('Error: ${response.reasonPhrase}');
// //       return null;
// //     }
// //   } catch (e) {
// //     print('Exception: $e');
// //     return null;
// //   }
// //    finally {
// //       _isLoading = false;
// //       notifyListeners();
 
// // }
// //    }}



// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:sketch/models/getApiSingleUser_Provider.dart';


// class SingleUserProvider extends ChangeNotifier {
//   String _email = '';
//   String _firstName = '';
//   String _lastName = '';
//   String _avatar = '';
//   bool _isLoading = false;
//   Data? _data;

//   String get email => _email;
//   String get firstName => _firstName;
//   String get lastName => _lastName;
//   String get avatar => _avatar;
//   bool get isLoading => _isLoading;
//   Data? get data => _data;

//   Future<SingleuserApiProvider?> fetchUser() async {
//     _isLoading = true;
//     notifyListeners();

//     var headers = {
//       'Accept': 'application/json',
//       'Authorization':
//           'Bearer 59387|rVxTQUFzgeptn2NWBgcNxnO4exfHo880AJApBJEI49e733d9',
//     };

//     var request = http.Request('GET', Uri.parse('https://reqres.in/api/users/2'))
//       ..headers.addAll(headers);

//     try {
//       http.StreamedResponse response = await request.send();

//       if (response.statusCode == 200) {
//         String responseBody = await response.stream.bytesToString();
//         final dataMap = json.decode(responseBody);
//         final singleUserApi = SingleuserApiProvider.fromMap(dataMap);
//         _email = singleUserApi.data!.email;
//         _firstName = singleUserApi.data!.firstName;
//         _lastName = singleUserApi.data!.lastName;
//         _avatar = singleUserApi.data!.avatar;
//         return singleUserApi;
//       } else {
//         print('Error: ${response.reasonPhrase}');
//         return null;
//       }
//     } catch (e) {
//       print('Exception: $e');
//       return null;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sketch/models/getApiSingleUser_Provider.dart';

class SingleUserProvider extends ChangeNotifier {
  Data? _data;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  Data? get data => _data;

  Future<void> fetchUser() async {
    _isLoading = true;
    notifyListeners();  // This will trigger UI updates

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer 59387|rVxTQUFzgeptn2NWBgcNxnO4exfHo880AJApBJEI49e733d9',
    };

    var request = http.Request('GET', Uri.parse('https://reqres.in/api/users/5'));
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        final dataMap = json.decode(responseBody);
        final singleUserApi = SingleuserApiProvider.fromMap(dataMap);
        _data = singleUserApi.data; // Assigning the data to the data property
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); // This will stop the shimmer effect
    }
  }
}
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:sketch/helpers/singleUser_provider.dart';
// import 'package:sketch/models/getApiSingleUser_Provider.dart';




// class UserScreen extends StatefulWidget {
//   @override
//   State<UserScreen> createState() => _UserScreenState();
// }

// class _UserScreenState extends State<UserScreen> {
//   SingleuserApiProvider? _userApi;
//   bool _isLoading = false;
  

//   // void _fetchData() async {
//   //   setState(() {
//   //     _isLoading = true;
//   //   });

//   //   try {
//   //     final userApi = await fetchUser();
//   //     setState(() {
//   //       _userApi = userApi;
//   //     });
//   //   } catch (e) {
//   //     // Handle errors here
//   //     print(e);
//   //   } finally {
//   //     setState(() {
//   //       _isLoading = false;
//   //     });
//   //   }
//   // }
 
//   @override
//   Widget build(BuildContext context) {
//      final userProvider = Provider.of<SingleUserProvider>(context);
    
//     return Scaffold(
//       appBar: (_userApi != null && _userApi!.data != null)? AppBar(title:Text('${_userApi!.data!.firstName}'))
//       : AppBar(title:Text('User Info')),
      
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Consumer(builder: (context, value, child) {
//          return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                // if (_isLoading) CircularProgressIndicator(),
//                 if (value != null && _userApi!.data != null) ...[
//                    _isLoading
//                   ? Shimmer.fromColors(
//                       baseColor: Color.fromARGB(255, 163, 157, 157),
//                       highlightColor: Color.fromARGB(255, 201, 199, 203),
//                       child: Container(
//                         width: 150.0,
//                         height: 150.0,
//                         color: Color.fromARGB(255, 50, 110, 43),
//                       ),
//                     )
//                   : _userApi!.data!.avatar != null
//                       ? Container(
//                           width: 150.0,
//                           height: 150.0,
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image: NetworkImage(_userApi!.data!.avatar!),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         )
//                             : Container(
//                           width: double.infinity,
//                           height: 200.0,
//                           color: Colors.grey[300],
//                           child: Icon(
//                             Icons.image,
//                             size: 100,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                  // Image.network(_userApi!.data!.avatar!),
//                   Text('Email: ${userProvider.data?.email}'),
                 
//                   Text('First Name: ${userProvider.data?.firstName}'),
//                   Text('Last Name: ${userProvider.data?.lastName}'),
//                 ] else if (!_isLoading) ...[
//                   Text('No data available.'),
//                 ],
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: userProvider.fetchUser,
//                   child: Text('Fetch Data'),
//                 ),
//               ],
//             ),
//           );
//         } ),
          
//         ),
      
//     );
//   }
  
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sketch/helpers/singleUser_provider.dart';

class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<SingleUserProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(userProvider.data != null 
            ? '${userProvider.data!.firstName}' 
            : 'User Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<SingleUserProvider>(builder: (context, provider, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Shimmer effect while loading
                if (provider.isLoading) 
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 150.0,
                      height: 150.0,
                      color: Colors.grey[300],
                    ),
                  )
                else if (provider.data != null) ...[
                  provider.data!.avatar.isNotEmpty
                      ? Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(provider.data!.avatar),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          width: 150.0,
                          height: 150.0,
                          color: Colors.grey[300],
                          child: Icon(Icons.image, size: 100, color: Colors.grey[600]),
                        ),
                  SizedBox(height: 20),
                  Text('Email: ${provider.data!.email}'),
                  Text('First Name: ${provider.data!.firstName}'),
                  Text('Last Name: ${provider.data!.lastName}'),
                ] else ...[
                  Text('No data available.'),
                ],
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: provider.fetchUser,
                  child: Text('Fetch Data'),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';

// class camera extends StatefulWidget {
//   static const routeName = '/ProfileScreen';

//   const camera({Key? key}) : super(key: key);

//   @override
//   State<camera> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<camera> {
//   File? _selectedImage;

//   bool isEditBooking = false;

//   TextEditingController startDate = TextEditingController(
//     text: DateFormat('yyyy-MM-dd HH:mm').format(
//       DateTime.now(),
//     ),
//   );

//   _showImagePickerBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (BuildContext context) {
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             ListTile(
//               leading: const Icon(Icons.camera),
//               title: const Text('Take a picture'),
//               onTap: () {
//                 _openCamera(context);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.photo_library),
//               title: const Text('Select from gallery'),
//               onTap: () {
//                 _openGallery(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _openCamera(BuildContext context) async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.camera);
//     setState(() {
//       _selectedImage = File(pickedFile!.path);
//     });
//     Navigator.pop(context);
//   }

//   void _openGallery(BuildContext context) async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     setState(() {
//       _selectedImage = File(pickedFile!.path);
//     });
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         centerTitle: true,
//         title: Text(
//           "Profile Screen",
//           style: Theme.of(context).textTheme.headline6,
//         ),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             const SizedBox(height: (20)),
//             InkWell(
//               onTap: () => _showImagePickerBottomSheet(context),
//               child: Stack(
//                 children: [
//                   Container(
//                       width: 100,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           width: 2,
//                           color: Colors.cyan,
//                         ),
//                         image: _selectedImage != null
//                             ? DecorationImage(
//                                 image: FileImage(_selectedImage!),
//                                 fit: BoxFit.fill,
//                               )
//                             : const DecorationImage(
//                                 image: AssetImage(
//                                     "assets/images")), // Fallback in case no image is selected
//                       )),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: Container(
//                       width: 30,
//                       height: 30,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.orange,
//                       ),
//                       child: const Icon(
//                         Icons.camera_alt,
//                         color: Colors.white,
//                         size: 18,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class time_date extends StatefulWidget {
  

  const time_date({Key? key}) : super(key: key);

  @override
  State<time_date> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<time_date> {
  bool isEditBooking = false;

  TextEditingController startDate = TextEditingController(
    text: DateFormat('MM-dd-yyyy HH:mm').format(
      DateTime.now(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Pick Date Time",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: (20)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                controller: startDate,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Start Time:*',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10).r,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20).r,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.amber),
                    borderRadius: BorderRadius.circular(10).r,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10).r,
                  ),
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 228, 37, 37), fontSize: 14.sp),
                ),
                onTap: () {
                  // Use try-catch to handle invalid format
                  DateTime initialDate;
                  try {
                    initialDate = DateTime.parse(startDate.text);
                  } catch (e) {
                    // Handle the error by providing a default date, like the current date
                    initialDate = DateTime.now();
                    print('Error parsing date: ${e.toString()}');
                  }
                  BottomPicker.dateTime(
                    pickerTitle: Text('Date'),
                    use24hFormat: true,
                    dateOrder: DatePickerDateOrder.dmy,
                    initialDateTime: initialDate,
                    pickerTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: (15.sp),
                      color: Color.fromARGB(255, 6, 6, 6),
                    ),
                    onChange: (index) {
                      print("Index:>>>>     $index");
                    },
                    onSubmit: (date) {
                      // Format the date and update the text field
                      final DateFormat dateFormat =
                          DateFormat('MM-dd-yyyy HH:mm');
                      startDate.text = dateFormat.format(date);
                      print('startDate >>>>>>>>>>> ...${startDate.text}');
                    },
                    bottomPickerTheme: BottomPickerTheme.temptingAzure,
                  ).show(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

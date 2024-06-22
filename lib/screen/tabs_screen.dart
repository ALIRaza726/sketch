import 'package:flutter/material.dart';
import 'dart:math' as math;

class tabs_screen extends StatefulWidget {
  const tabs_screen({super.key});

  @override
  State<tabs_screen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<tabs_screen> {
  Future popupDialog() {
    return showDialog(
      barrierColor: Colors.black54,
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: const Text('Tabs Screen'),
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(120),
                child: TabBar(
                    indicatorColor: Colors.green,
                    dividerColor: Colors.black26,
                    labelColor: Colors.brown,
                    overlayColor: MaterialStatePropertyAll(Colors.greenAccent),
                    tabs: [
                      Tab(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('Search'), Icon(Icons.search)],
                      )),
                      Tab(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Customer'),
                          Icon(Icons.person_outline)
                        ],
                      )),
                      // Tab(icon: Icon(Icons.person)),
                    ]),
              )),
          body: TabBarView(children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      inputFormatters:  const [
                       // DecimalTextInputFormatter(decimalRange: 2)
                      ],
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      // // autovalidate: true,
                      // keyboardType: TextInputType.numberWithOptions(
                      //     signed: false, decimal: false),
                      // validator: (input) {
                      //   final isDigitOnly = int.tryParse(input!);
                      //   return isDigitOnly == null
                      //       ? 'input sed to be digit only'
                      //       : null;
                      // },
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Customer Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: const Text('Walk-In Customer'))
                  ],
                ),
              ),
            ),
            Center(
                child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                    cursorHeight: 20,
                    mouseCursor: MaterialStateMouseCursor.textable,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1),
                          child: Icon(
                            Icons.edit,
                            size: 20,
                            color: Color.fromARGB(255, 3, 1, 24),
                          ),
                        ),
                        hintText: 'Name:',
                        hintStyle: const TextStyle(
                            fontSize: 20, color: Color.fromARGB(255, 20, 2, 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 63, 54, 238))),
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    
                  ],
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                    cursorHeight: 20,
                    mouseCursor: MaterialStateMouseCursor.textable,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1),
                          child: Icon(
                            Icons.edit,
                            size: 10,
                            color: Color.fromARGB(255, 3, 1, 24),
                          ),
                        ),
                        hintText: 'E_Mail:',
                        hintStyle: const TextStyle(
                            fontSize: 20, color: Color.fromARGB(255, 20, 2, 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 63, 54, 238))),
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                   
                  ],
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                    cursorHeight: 20,
                    mouseCursor: MaterialStateMouseCursor.textable,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1),
                          child: Icon(
                            Icons.edit,
                            size: 10,
                            color: Color.fromARGB(255, 3, 1, 24),
                          ),
                        ),
                        hintText: 'Password:',
                        hintStyle: const TextStyle(
                            fontSize: 20, color: Color.fromARGB(255, 20, 2, 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 63, 54, 238))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                      backgroundColor: const MaterialStatePropertyAll(
                          Color.fromARGB(255, 125, 180, 164)),
                    ),
                    onPressed: () {
                      popupDialog();
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ]),
        ));
  }
}

class DecimalTextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  get math => null;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}

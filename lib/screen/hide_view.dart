import 'package:flutter/material.dart';

class hide_view extends StatefulWidget {
  const hide_view({super.key});

  @override
  State<hide_view> createState() => __hide_viewStateState();
}

class __hide_viewStateState extends State<hide_view> {
   bool department = false;
   final departmentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
         body: Column(
          children: [
             InkWell(
                onTap: () {
                  setState(() {
                    department = !department;
                    print('department : $department');
                  });
                },
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: department,
                      activeColor: Color.fromARGB(255, 103, 199, 228),
                      onChanged: (bool? newValue) {
                        setState(() {
                          department = newValue!;
                          print('department : $department');
                        });
                      },
                    ),
                    const Expanded(child: Text('Department')),
                  ],
                ),
              ),
              if (department == true)
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: departmentController,
                        readOnly: department ? false : true,
                        onTap: () {},
                        decoration: InputDecoration(
                            hintText: ('None Selected'),
                            labelText: ('Select Department'),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30),
                            )
                            // suffixIcon: Icon(
                            //   Icons.search,
                            //   color: buttonColor,
                            // ),
                            ),
                      ),
                      const SizedBox(height: 40),
                       TextFormField(
                        controller: departmentController,
                        readOnly: department ? false : true,
                        onTap: () {},
                        decoration: InputDecoration(
                            hintText: ('None Selected'),
                            labelText: ('Select Name'),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30),
                            )
                            // suffixIcon: Icon(
                            //   Icons.search,
                            //   color: buttonColor,
                            // ),
                            ),
                      ),
                    ],
                  ),
                ),
                
          ],
         ),
      ),
    );
  }
}
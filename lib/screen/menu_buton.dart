import 'package:flutter/material.dart';

class MenuButon extends StatefulWidget {
  const MenuButon({super.key});

  @override
  State<MenuButon> createState() => _MenuButonState();
}

class _MenuButonState extends State<MenuButon> {
  String? select = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 290,
            ),
             Center(
               child: PopupMenuButton(
                  onSelected: (String result) {
                    setState(() {
                      select = result;
                    });
                     
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('You Have Selected: $result'),
                      ),
                    );
                  },
                  // icon: const Icon(Icons.menu_outlined,
                  //     color: Color.fromRGBO(63, 33, 255, 1)),
                  itemBuilder: (context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem(
                      value: '1st Menu',
                      child: Text('Menu num 1'),
                    ),
                    const PopupMenuItem(
                      value: '2nd Menu',
                      child: Text('Menu num 2'),
                    ),
                    const PopupMenuItem(
                      value: '3rd Menu',
                      child: Text('Menu num 3'),
                    ),
                  ],
                ),
             ),
              Text(
                'You Have Selected MenuButton : $select',
                style: const TextStyle(
                    color: Color.fromARGB(255, 243, 70, 57), fontSize: 20),
              ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sketch/models/menuBtn_provider.dart';

class MenuButon extends StatelessWidget {
  const MenuButon({super.key});

  @override
 
  Widget build(BuildContext context) {
     //final valuelist1 = Provider.of<MenuButtonProvider>(context);
    return SafeArea(
      child: Scaffold(
        body:  Consumer<MenuButtonProvider>(
            builder: (context, menu, child) {
              return
        Column(
          children: [
            const SizedBox(
              height: 290,
            ),
           
              
                Center(
                 child: PopupMenuButton(
                    onSelected: (String result) {
                     
                         Provider.of<MenuButtonProvider>(context, listen: false)
                      .addvalue(result);
                     
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('You Have Selected: ${menu.valuelist}'),
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
                'You Have Selected MenuButton : ${menu.valuelist}\n',
                style: const TextStyle(
                    color: Color.fromARGB(255, 243, 70, 57), fontSize: 20),
              ),
          ],
        );
  }),
    ));
  }
}


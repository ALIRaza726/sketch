import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sketch/models/listview_model.dart';

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({super.key});

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  
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

  
  
  final List<String> items =
      List<String>.generate(6, (index) => "Item ${index + 1}");
  Map<String, String?> selectedItems = {};
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 136, 210, 225),
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 53, 165, 179),
            title: const Text('ListView'),
            actions: [
              IconButton(
                  onPressed: () {
                    popupDialog();
                  },
                  icon: const Icon(Icons.add))
            ]),
        body: SingleChildScrollView(
          child: Column(children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemCount: items.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.star_border_purple500),
                    title: Text(
                      items[index],
                      style:
                          TextStyle(color: Color.fromARGB(255, 44, 142, 155)),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Item ${index + 2}',
                        ),
                        Text('Phone Num ${index + 3}'),
                      ],
                    ),
                    trailing: Consumer<ListProvider>(
          builder: (context, list, child) {
                            
               return DropdownButton<String>(
                        underline: Container(
                          height: 2,
                          color: Colors.cyan,
                        ),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 53, 165, 179)),
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 10,
                        value: selectedItems[
                            items[index]], // Use index to refer to a single item
                        items: <String>['Item1', 'Item2', 'Item3', 'Item4']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          // setState(() {
                          //   selectedItems[items[index]] =
                          //       newValue; // Update using index
                          // });
                           Provider.of<ListProvider>(context, listen: false)
                      .addvalue(items[index],newValue);
                      print('aa:${selectedItems[newValue]}');
                      setState(() {
                        
                   
                       Text(
                            '${ selectedItems[newValue]}',
                            
                            style: const TextStyle(
                              color: Color.fromARGB(255, 165, 40, 40),
                              fontSize: 5,
                            ),
                            textAlign: TextAlign.center,
                          );
                             });
                        },
                      );
              })));
                    // title: Text('Item $index'),
                    // onTap: () {
                    //   print('Item $index tapped');
                    // },
              
                
              },
              ),
              ],
              ),
              ),
              ),
              );
          
          
    }
}





























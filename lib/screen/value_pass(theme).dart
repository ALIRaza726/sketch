
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sketch/screen/value_pass(provider).dart';

class provider_theme extends StatelessWidget {
  const provider_theme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 154, 251),
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return SwitchListTile(
                  activeColor: Color.fromARGB(255, 233, 28, 35),
                  title: Text('Dark Theme'),
                  value: themeProvider.isDarkTheme,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:math' as math;

class tabs_stepper extends StatelessWidget {
 final String personal;
 final String study;

  const tabs_stepper({Key? key, required this.personal, required this.study}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: const Text('Tabs Screen Stepper'),
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
                        children: [Text('Personal'), Icon(Icons.person)],
                      )),
                      Tab(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Educational'),
                          Icon(Icons.book)
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
                    Center(child: Text('Name : $personal',style: TextStyle(color: Colors.blueAccent,fontSize: 30),)),
                   
                  ],
                ),
              ),
          ),
           Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Text('Qualification : $study',style: TextStyle(color: Colors.blueAccent,fontSize: 30),)),
                   
                  ],
                ),
              ),
          ),
          ],),
          ),
          );
           

  }}
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class chang_language extends StatefulWidget {
  
  const chang_language({super.key});

  @override
  State<chang_language> createState() => _chang_languageState();
  
}
 

class _chang_languageState extends State<chang_language> {
  bool _useRtlText=false;
  @override
  Widget build(BuildContext context) {
        return   Scaffold(
        backgroundColor: Colors.deepOrange,
        body: ListView(
          padding: const EdgeInsets.only(top: 50),
          children: [
            _buildMarquee(),
            _buildComplexMarquee(),
          ].map(_wrapWithStuff).toList(),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => setState(() => _useRtlText = !_useRtlText),
          label: !_useRtlText
              ? const Text('Switch to German')
              : const Text('Zu englisch wechseln'),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
      );
    
  }

  Widget _buildMarquee() {
    return Marquee(
      key: Key("$_useRtlText"),
      text: !_useRtlText
          ? 'There once was a boy who told this story about a boy:'
          : 'Es war einmal ein Junge, der diese Geschichte über einen Jungen erzählte:',
      velocity: 50.0,
    );
  }

  Widget _buildComplexMarquee() {
    return Marquee(
      key: Key("$_useRtlText"),
      text: !_useRtlText
          ? 'Some sample text that takes some space.'
          : 'Einige Beispieltexte, die etwas Platz beanspruchen',
      style: const TextStyle(fontWeight: FontWeight.bold),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.center,
      
      blankSpace: 40,
      velocity: 100,
      pauseAfterRound: const Duration(seconds: 1),
      showFadingOnlyWhenScrolling: false,
      fadingEdgeStartFraction: 0.1,
      fadingEdgeEndFraction: 0.1,
      numberOfRounds: 3,
      startPadding: 20,
      accelerationDuration: const Duration(seconds: 1),
      accelerationCurve: Curves.bounceIn,
      decelerationDuration: const Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
      textDirection: _useRtlText ? TextDirection.rtl : TextDirection.ltr,
    );
  }

  Widget _wrapWithStuff(Widget fetchData) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(height: 50, color: Color.fromARGB(255, 253, 253, 252), child: fetchData),
    );
  }
}
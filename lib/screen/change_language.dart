import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class chang_language extends StatefulWidget {
  const chang_language({super.key});

  @override
  State<chang_language> createState() => _chang_languageState();
}
final _useRtlText=false;

class _chang_languageState extends State<chang_language> {
  @override
  Widget build(BuildContext context) {
        return MaterialApp(
      title: 'Marquee',
      home: Scaffold(
        backgroundColor: Colors.deepOrange,
        body: ListView(
          padding: const EdgeInsets.only(top: 50),
          children: [
            _buildMarquee(),
            _buildComplexMarquee(),
          ].map(_wrapWithStuff).toList(),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => setState(() => useRtlText = !useRtlText),
          label: !_useRtlText
              ? const Text('Switch to German')
              : const Text('Zu englisch wechseln'),
          backgroundColor: Colors.pink,
        ),
      ),
    );
  }

  Widget _buildMarquee() {
    return Marquee(
      key: Key("$_useRtlText"),
      text: !_useRtlText
          ? 'There once was a boy who told this story about a boy: '
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
      crossAxisAlignment: CrossAxisAlignment.start,
      blankSpace: 20,
      velocity: 100,
      pauseAfterRound: const Duration(seconds: 1),
      showFadingOnlyWhenScrolling: true,
      fadingEdgeStartFraction: 0.1,
      fadingEdgeEndFraction: 0.1,
      numberOfRounds: 3,
      startPadding: 10,
      accelerationDuration: const Duration(seconds: 1),
      accelerationCurve: Curves.linear,
      decelerationDuration: const Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
      textDirection: _useRtlText ? TextDirection.rtl : TextDirection.ltr,
    );
  }

  Widget _wrapWithStuff(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(height: 50, color: Colors.white, child: child),
    );
  }
}
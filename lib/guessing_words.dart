import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'dart:math';
import 'coundown_timer.dart';
import 'game_data.dart';

class GuessingWordsWidget extends StatefulWidget {
  final Category category;
  final int startTime;
  GuessingWordsWidget({Key key, this.category, this.startTime})
      : super(key: key);
  State createState() => _GuessingWordsState();
}

class _GuessingWordsState extends State<GuessingWordsWidget> {
  bool hasTimerStopped = false;
  bool hasPassed = false;
  bool hasWon = false;
  List<double> _accelerometerValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
  <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();

//    _streamSubscriptions
//        .add(accelerometerEvents.listen((AccelerometerEvent event) {
//      setState(() {
//
//        if( event.x < 7 && event.y > 7 ){
//          hasPassed = true;
//          hasWon = false;
//        }
//
//        if( event.x < 7 && event.y > -6 ){
//          hasPassed = false;
//          hasWon = true;
//        }
//      });
//    }));

  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }


  @override
  Widget build(BuildContext context) {
    final List<String> accelerometer =
    _accelerometerValues?.map((double v) => v.toStringAsFixed(1))?.toList();

    var messageToShow = hasTimerStopped? "Game Over!!" : selectRandomWord(widget.category.words);
    var messageWidget = Text(
      messageToShow,
      style: TextStyle(color: hasTimerStopped? Colors.red : Colors.white, fontSize: 54.0),
    );


    return GestureDetector(
        onHorizontalDragEnd: (details) {
          _goBack(context, details);
        },
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          CountDownTimer(
            secondsRemaining: widget.startTime,
            whenTimeExpires: () {
              setState(() {
                hasTimerStopped = true;
              });
            },
            countDownTimerStyle: TextStyle(
                color: Colors.white,
                backgroundColor: Colors.blue,
                fontSize: 54.0),
          ),
          Container(
            height: 150,
            width: 850,
            child: Center(
              child: messageWidget,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0), color: Colors.blue),
          )
        ]));
  }

  void _goBack(BuildContext context, DragEndDetails details) {
    var velocity = details.primaryVelocity;
    if (velocity > 0) {
      Navigator.pop(context);
    }
  }

  String selectRandomWord(List<String> words) {
    var randomGenerator = new Random();
    return words[randomGenerator.nextInt(words.length)];
  }

}



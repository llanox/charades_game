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
  bool _hasTimerStopped = false;
  bool _hasPassed = false;
  bool _isCorrect = false;


  @override
  void initState() {
    super.initState();

    gyroscopeEvents.listen((GyroscopeEvent event) {
      // print('Output x:[ ${event.x} ] y:[ ${event.y} ] z:[ ${event.z} ]');

      if (event.y < -5 && event.x < 0 && event.z < 0) {
        print('Correct x:[ ${event.x} ] y:[ ${event.y} ] z:[ ${event.z} ]');
        setState(() {
          _isCorrect = true;
          _hasPassed = false;

        });
      }

      if (event.y > 5 && event.x > 0 && event.z > 0.5) {
        print('Pass it x:[ ${event.x} ] y:[ ${event.y} ] z:[ ${event.z} ]');
        setState(() {
          _isCorrect = false;
          _hasPassed = true;

        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    var timerWidget =  CountDownTimer(
      secondsRemaining: widget.startTime,
      whenTimeExpires: () {
        setState(() {
          _hasTimerStopped = true;
        });
      },
      countDownTimerStyle: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.blue,
          fontSize: 54.0),
    );

    var raisedButton =  RaisedButton(
      padding: const EdgeInsets.all(8.0),
      textColor: Colors.white,
      color: Colors.blue,
      onPressed: (){
        _playAgain(context);
        },
      child: new Text("Play Again",style: TextStyle(
          color: Colors.white, fontSize: 54.0),),
    );


    var dynamicWidget = _hasTimerStopped ? raisedButton : timerWidget;


    var messageToShow = _hasTimerStopped
        ? "Time Up!!"
        : _selectRandomWord(widget.category.words);

    var messageColor = _hasTimerStopped? Colors.red: Colors.white;


   if(_hasPassed){
      messageToShow = "Pass it";
      messageColor = Colors.yellow;
   }

   if(_isCorrect){
     messageToShow = "Correct!!";
     messageColor = Colors.lightGreen;
   }


    var messageWidget = Text(
      messageToShow,
      style: TextStyle(
          color: messageColor, fontSize: 54.0),
    );

    return GestureDetector(
        onDoubleTap: (){
          _showANewWord();
        },
        onHorizontalDragEnd: (details) {
          _goBack(context, details);
        },
        onVerticalDragEnd: (details) {
          _processGesture(details);
        },
        child:  Container(
          height: 150,
          width: 850,
          child: Center(
            child:   Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              dynamicWidget,
              Container(
                height: 150,
                width: 850,
                child: Center(
                  child: messageWidget,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0), color: Colors.blue),
              )
            ]),
          ),
        )
    );
  }

  void _goBack(BuildContext context, DragEndDetails details) {
    var velocity = details.primaryVelocity;
    if (velocity > 0) {
      Navigator.pop(context);
    }
  }

  void _playAgain(BuildContext context) {
      Navigator.pop(context);
  }

  String _selectRandomWord(List<String> words) {
    var randomGenerator = new Random();
    return words[randomGenerator.nextInt(words.length)];
  }

  void _processGesture(DragEndDetails details) {
    if(_hasTimerStopped) return;
    var velocity = details.primaryVelocity;

    if (velocity > 0) {
      setState(() {
        print("+ ");
        _isCorrect = true;
        _hasPassed = false;
      });
    } else {
      print("- ");
      setState(() {
        _isCorrect = false;
        _hasPassed = true;
      });
    }
  }

  void _showANewWord() {
    print('Double Tap ${_hasTimerStopped}');
    if(_hasTimerStopped) return;
    setState(() {
      _isCorrect = false;
      _hasPassed = false;
      _hasTimerStopped = false;
    });

  }
}

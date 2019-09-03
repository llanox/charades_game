import 'package:flutter/material.dart';
import 'game_data.dart';
import 'guessing_words.dart';



class CharadesGameApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CharadesGameState();
  }
}

class _CharadesGameState extends State<CharadesGameApp> {
  List _wordCategories = getDummyCategories();
  var _gameSettings = getDummyGameSettings();


  void openCategory(Category selectedCategory, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => GuessingWordsWidget(category: selectedCategory, startTime: _gameSettings.wordsTimerInSec,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Categories',
                  style: TextStyle(fontSize: 30, color:Colors.white , fontStyle: FontStyle.normal, fontWeight: FontWeight.bold )
              ),
            ),
            body: GridView.builder(
                itemCount: _wordCategories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        openCategory(_wordCategories[index], context);
                      },
                      child: Container(
                        decoration: BoxDecoration( borderRadius: BorderRadius.circular(20.0), color: Colors.blue),
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.all(10.5),
                        alignment: Alignment.center,
                        child: Text('${_wordCategories[index].name}',
                            style: TextStyle(fontSize: 30, color:Colors.white , fontStyle: FontStyle.normal, fontWeight: FontWeight.bold )
                        ),
                      ));
                })));
  }
}
import 'package:flutter/material.dart';

main() => runApp(CharadesGameApp());

class CharadesGameApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CharadesGameState();
  }
}

class _GuessingWordsRoute extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _GuessingWordsState();
  }
}



class _GuessingWordsState extends State{
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Second Screen'), );
  }
}

class _CharadesGameState extends State<CharadesGameApp> {
  List<String> _wordCategories = ['Food', 'Movies', 'Countries'];

  void _GoTo(String page, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _GuessingWordsRoute()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Categories'),
            ),
            body: ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemCount: _wordCategories.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      _GoTo('${_wordCategories[index]}', context);
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      alignment: Alignment.center,
                      color: Colors.amber[600],
                      child: Card(child: Text('${_wordCategories[index]}')),
                    ));
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            )));
  }
}

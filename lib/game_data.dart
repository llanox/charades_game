class Category {
  final int code;
  final String name;
  final List<String> words;

  Category(this.code, this.name, this.words);

}

class GameSettings {
  final int wordsTimerInSec;

  GameSettings(this.wordsTimerInSec);
}


List<Category> getDummyCategories(){
  return [
    Category(0, 'Food', ['Hamburguer', 'HotDog', 'Ceviche']),
    Category(1, 'Movies 90\'s', ['Terminator 2', 'Titanic', 'Forrest Gump', 'Toy Story']),
    Category(2, 'Animals', ['Cat', 'Dog', 'Monkey', 'Bird', 'Snake', 'Donkey', 'Cocodrile']),
    Category(3, 'Profession', ['Doctor', 'Plumber', 'Engineer', 'Teacher']),
    Category(4, 'Plants', ['Cilantro', 'Mango']),
    Category(5, 'Places', ['Cairo', 'Paris'])
  ];
}

GameSettings getDummyGameSettings(){
  return GameSettings(60);
}


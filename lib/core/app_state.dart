import 'package:english_words/english_words.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppState extends ChangeNotifier {
  // Obtain shared preferences.
  late SharedPreferences prefs;
  var current = WordPair.random();
  var favorites = <WordPair>[];
  var history = <WordPair>[];

  GlobalKey? historyListKey;

  AppState() {
    SharedPreferences.getInstance().then((prefs) {
      this.prefs = prefs;
      // for development to be able to clear SharedPreferences
      // prefs.clear();

      final List<String>? favorites = prefs.getStringList('favorites');
      if (favorites != null) {
        this.favorites = favorites.map((pair) =>
            WordPair(
                prefs.getStringList(pair)![0],
                prefs.getStringList(pair)![1]
            )).toList();
      }

      final List<String>? history = prefs.getStringList('history');
      if (history != null) {
        var animatedList = historyListKey?.currentState as AnimatedListState?;
        this.history = history.map((pair) =>
            WordPair(
                prefs.getStringList(pair)![0],
                prefs.getStringList(pair)![1]
            )).toList();
        // fill animated list (without this command it is empty, even when there
        // are some elements in history)
        for(String pair in history) {
          animatedList?.insertItem(0);
        }
      }

      notifyListeners();
    });
  }

  void getNext() {
    history.insert(0, current);
    prefs.setStringList('history', history.map((pair) => pair.asString).toList());
    prefs.setStringList(current.asString, [current.first, current.second]);
    var animatedList = historyListKey?.currentState as AnimatedListState?;
    animatedList?.insertItem(0);
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite([WordPair? pair]) {
    pair = pair ?? current;
    if (favorites.contains(pair)) {
      favorites.remove(pair);
      prefs.setStringList('favorites', favorites.map((pair) => pair.asString).toList());
    } else {
      favorites.add(pair);
      prefs.setStringList('favorites', favorites.map((pair) => pair.asString).toList());
      prefs.setStringList(pair.asString, [pair.first, pair.second]);
    }
    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    prefs.setStringList('favorites', favorites.map((pair) => pair.asString).toList());
    notifyListeners();
  }
}
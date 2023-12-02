import 'dart:convert';

import 'package:animator/DetailScreen.dart';
import 'package:animator/HomeScreen.dart';
import 'package:animator/Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlanetModel extends ChangeNotifier {

  Future<void> loadJson() async {
    String data = await rootBundle.loadString('assets/planets.json');
    List jsondata = jsonDecode(data);
    model = Model.parselist(jsondata);
    print(model);
    notifyListeners();
  }
}
class FavoritePlanetss extends ChangeNotifier {
  static const String _key = 'favorite_planets';



  void addToFavorites(Model planet) async {
    FavoritePlanet.add(planet);
    notifyListeners();
    await _saveFavorites();
  }

  void removeFromFavorites(Model planet) async {
    FavoritePlanet.remove(planet);
    notifyListeners();
    await _saveFavorites();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = FavoritePlanet.map((planet) => planet.toJson()).toList();
    prefs.setString(_key, jsonEncode(favoritesJson));
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getString(_key);
    if (favoritesJson != null) {
      final favoritesList = jsonDecode(favoritesJson) as List<dynamic>;
      FavoritePlanet = favoritesList.map((json) => Model.fromJson(json)).toList();
      notifyListeners();
    }
  }
}

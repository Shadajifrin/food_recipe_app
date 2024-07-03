import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:food_recipe_app/model/recipes_model.dart';

class SearchScreenController with ChangeNotifier {
  List<Recipe> searchedRecipes = [];
  bool isLoading = false;

  Future<void> searchRecipes(String query) async {
    if (query.isEmpty) {
      searchedRecipes = [];
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    final url = Uri.parse("https://dummyjson.com/recipes/search?q=$query");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        searchedRecipes = (decodedData['recipes'] as List)
            .map((data) => Recipe.fromJson(data))
            .toList();
      } else {
        print("API request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}

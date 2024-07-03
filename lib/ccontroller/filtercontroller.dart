import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:food_recipe_app/model/recipes_model.dart';

class CategoryController with ChangeNotifier {
  List<Recipe> recipesModel = [];
  List<Recipe> filteredRecipes = [];
  bool isLoading = false;

  CategoryController() {
    fetchData();
  }

  Future<void> fetchData({String? mealType}) async {
    isLoading = true;
    notifyListeners();

    String apiUrl = "https://dummyjson.com/recipes/";
    if (mealType != null) {
      apiUrl += "?mealType=$mealType";
    }

    final url = Uri.parse(apiUrl);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        recipesModel = (decodedData['recipes'] as List)
            .map((data) => Recipe.fromJson(data))
            .toList();
        filteredRecipes = List.from(recipesModel);
      } else {
        print("API request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  void filterByMealType(String mealType) {
    fetchData(mealType: mealType);
  }
}

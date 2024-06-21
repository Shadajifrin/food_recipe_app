import 'package:flutter/material.dart';
import 'package:food_recipe_app/model/recipes_model.dart';
import 'package:food_recipe_app/service/recipeservice.dart';
import 'package:food_recipe_app/view/detail.dart';

class RecipeHomeScreen extends StatefulWidget {
  const RecipeHomeScreen({super.key});

  @override
  State<RecipeHomeScreen> createState() => _RecipeHomeScreenState();
}

class _RecipeHomeScreenState extends State<RecipeHomeScreen> {
  List<Recipe> recipesModel = [];

  myRecipes() async {
    var value = await recipesItems();
    setState(() {
      recipesModel = value ?? [];
    });
  }

  @override
  void initState() {
    myRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Recipe"),
      ),
      body: recipesModel.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: recipesModel.length,
              itemBuilder: (context, index) {
                final recipe = recipesModel[index];
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to detail screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(recipe: recipe),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: NetworkImage(recipe.image ?? 'https://via.placeholder.com/150'), // Placeholder image
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(child: CircularProgressIndicator()), // Loading indicator while fetching data
    );
  }
}

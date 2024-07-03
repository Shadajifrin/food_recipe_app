import 'package:flutter/material.dart';
import 'package:food_recipe_app/ccontroller/filtercontroller.dart';
import 'package:food_recipe_app/ccontroller/searchcontroller.dart';
import 'package:food_recipe_app/model/recipes_model.dart';
import 'package:food_recipe_app/service/recipeservice.dart';
import 'package:food_recipe_app/view/detail.dart';

import 'package:food_recipe_app/view/filterscreen.dart';

import 'package:food_recipe_app/view/searchscreen.dart';
import 'package:provider/provider.dart';

class RecipeHomeScreen extends StatefulWidget {
  const RecipeHomeScreen({super.key});

  @override
  State<RecipeHomeScreen> createState() => _RecipeHomeScreenState();
}

class _RecipeHomeScreenState extends State<RecipeHomeScreen> {
  List<Recipe> recipesModel = [];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
    Widget body;
    switch (_selectedIndex) {
      case 0:
        body = recipesModel.isNotEmpty
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
            : Center(child: CircularProgressIndicator());
        break;
      case 1:
        body = ChangeNotifierProvider(
          create: (_) => CategoryController(),
          child: CategoryScreen(),
        );
        break;
      case 2:
        body = ChangeNotifierProvider(
          create: (_) => SearchScreenController(),
          child: SearchScreen(),
        );
        break;
      default:
        body = Center(child: Text('Unknown tab'));
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Food Recipe"),
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_list),
            label: 'Filter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

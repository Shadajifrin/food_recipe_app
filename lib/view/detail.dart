import 'package:flutter/material.dart';
import 'package:food_recipe_app/model/recipes_model.dart';

class DetailScreen extends StatelessWidget {
  final Recipe recipe;
  const DetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.network(
                  recipe.image ?? 'https://via.placeholder.com/450', // Placeholder image
                  fit: BoxFit.cover,
                  height: 450,
                  width: size.width,
                ),
                Positioned(
                  child: Padding(
                    padding: MediaQuery.of(context).padding,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -50,
                  right: 30,
                  left: 30,
                  child: Container(
                    height: 140,
                    width: size.width,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 2,
                          blurRadius: 2,
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipe.name ?? 'Unknown Recipe',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  if (recipe.mealType != null && recipe.mealType!.isNotEmpty)
                                    Text(
                                      recipe.mealType![0],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  if (recipe.cuisine != null)
                                    Row(
                                      children: [
                                        Text(
                                          " & ",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          recipe.cuisine!,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 35),
                              Icon(Icons.star, color: Colors.orange),
                              Text(recipe.rating?.toString() ?? '0.0'),
                              SizedBox(width: 50),
                              Icon(Icons.timer, color: Colors.blueAccent),
                              Text(recipe.cookTimeMinutes?.toString() ?? '0'),
                              SizedBox(width: 50),
                              Icon(Icons.accessibility, color: Colors.black),
                              Text("${recipe.caloriesPerServing?.toString() ?? '0'} kcl"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  const Text(
                    "Ingredients",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        recipe.ingredients?.length ?? 0,
                        (index) {
                          return Text(
                            "- ${recipe.ingredients![index]}",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Instructions",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        recipe.instructions?.length ?? 0,
                        (index) {
                          return Text(
                            "- ${recipe.instructions![index]}",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

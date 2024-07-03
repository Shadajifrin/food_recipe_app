import 'package:flutter/material.dart';
import 'package:food_recipe_app/ccontroller/searchcontroller.dart';
import 'package:provider/provider.dart';

import 'package:food_recipe_app/view/detail.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    SearchScreenController provider = Provider.of<SearchScreenController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Search Recipes"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.orangeAccent,
                              width: 3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        provider.searchRecipes(textController.text.toLowerCase());
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.orangeAccent)),
                      child: Icon(Icons.search,color:Colors.white,)),
                  )
                ],
              ),
              Expanded(
                child: provider.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: provider.searchedRecipes.length,
                        itemBuilder: (context, index) {
                          final recipe = provider.searchedRecipes[index];
                          return ListTile(
                            leading: Image.network(recipe.image ?? ''),
                            title: Text(recipe.name ?? ''),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(recipe: recipe),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

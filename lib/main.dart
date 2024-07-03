import 'package:flutter/material.dart';
import 'package:food_recipe_app/ccontroller/filtercontroller.dart';
import 'package:food_recipe_app/ccontroller/searchcontroller.dart';
import 'package:food_recipe_app/view/filterscreen.dart';
import 'package:food_recipe_app/view/searchscreen.dart';
import 'package:food_recipe_app/view/splash.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryController()),
        ChangeNotifierProvider(create: (_) => SearchScreenController()), // Fetch recipes initially
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        '/categories': (context) => CategoryScreen(),
        '/search': (context) => SearchScreen(),
      },
    );
  }
}

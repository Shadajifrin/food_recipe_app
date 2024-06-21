import 'package:http/http.dart' as http;
import 'package:food_recipe_app/model/recipes_model.dart';

Future<List<Recipe>?> recipesItems() async {
  Uri url = Uri.parse("https://dummyjson.com/recipes");
  var res = await http.get(url);
  try {
    if (res.statusCode == 200) {
      var data = recipesModelFromJson(res.body);
      return data.recipes;
    } else {
      print("Error occurred: ${res.statusCode}");
      return null;
    }
  } catch (e) {
    print(e.toString());
    return null;
  }
}

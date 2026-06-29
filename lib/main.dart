import 'package:flutter/material.dart';
import 'package:recipe/app/recipe_app.dart';
import 'package:recipe/app/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const RecipeApp());
}

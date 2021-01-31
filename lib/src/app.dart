import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/models.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';
import 'package:recetas/src/connection/server_controller.dart';
import 'package:recetas/src/screens/add_recipe_page.dart';
import 'package:recetas/src/screens/details_page.dart';
import 'package:recetas/src/screens/my_favotites_page.dart';
import 'package:recetas/src/screens/mys_recipes_page.dart';
import 'package:recetas/src/screens/register_page.dart';
import 'screens/home_page.dart';
import 'screens/login_page.dart';

ServerController _serverController = ServerController();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.cyan,
        accentColor: Colors.cyan[300],
        accentIconTheme: IconThemeData(
          color: Colors.white,
        ),
        appBarTheme: AppBarTheme(
            textTheme:
                TextTheme(title: TextStyle(color: Colors.white, fontSize: 22)),
            iconTheme: IconThemeData(color: Colors.white)),
      ),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          switch (settings.name) {
            case "/":
              return LoginPage(_serverController, context);
            case "/home":
              User loggedUser = settings.arguments;
              _serverController.loggedUser = loggedUser;
              return HomePage(_serverController);
            case "/register":
              User loggedUser = settings.arguments;
              return RegisterPage(
                _serverController,
                context,
                userToEdit: loggedUser,
              );
            case "/favorites":
              return MyFavoritesPage(
                _serverController,
              );
            case "/my_recipes":
              return MyRecipesPage(
                _serverController,
              );
            case "/add_recipe":
              return AddRecipePage(
                _serverController,
              );
            case "/edit_recipe":
              Recipe recipe = settings.arguments;
              return AddRecipePage(
                _serverController,
                recipe: recipe,
              );
            case "/details":
              Recipe recipe = settings.arguments;
              return DetailsPage(
                recipe: recipe,
                serverController: _serverController,
              );
          }
        });
      },
    );
  }
}

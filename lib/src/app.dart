import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';
import 'package:recetas/src/connection/server_controller.dart';
import 'screens/home_page.dart';
import 'screens/login_page.dart';

ServerController _serverController = ServerController();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.cyan,
        accentColor: Colors.cyan[300],
      ),
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          switch (settings.name) {
            case "/":
              return LoginPage(_serverController, context);
            case "/home":
              User userLogged = settings.arguments;
              return HomePage(userLogged);
          }
        });
      },
    );
  }
}

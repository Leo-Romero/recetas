import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/models.dart';

class HomePage extends StatefulWidget {
  final User loggedUser;

  HomePage(this.loggedUser, {Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(),
    );
  }
}

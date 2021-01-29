import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 60),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.cyan,
                Colors.cyan[300],
              ]),
            ),
            child: Image.asset(
              "assets/images/logo.png",
              color: Colors.white,
              height: 200,
            ),
          ),
          Center(
            child: Card(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 260),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: "Usuario:"),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Contraseña:"),
                      obscureText: true,
                    ),
                    Theme(
                      data:
                          Theme.of(context).copyWith(accentColor: Colors.white),
                      child: RaisedButton(
                        onPressed: () => _login(context),
                        color: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textColor: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Iniciar sesión"),
                            if (_loading)
                              Container(
                                height: 20,
                                width: 20,
                                margin: const EdgeInsets.only(left: 20),
                                child: CircularProgressIndicator(),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _login(BuildContext context) {
    if (!_loading) {
      setState(() {
        _loading = true;
      });
    }
  }
}

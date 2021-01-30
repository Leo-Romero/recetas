import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';
import 'package:recetas/src/components/image_picker_widget.dart';
import 'package:recetas/src/connection/server_controller.dart';

class RegisterPage extends StatefulWidget {
  ServerController serverController;
  BuildContext context;

  RegisterPage(this.serverController, this.context, {Key key})
      : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _loading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffKey = GlobalKey<ScaffoldState>();

  String userName = "";
  String password = "";
  Genrer genrer = Genrer.MALE;

  String _errorMessage = "";
  File imageFile;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        //key: _formKey,
        key: _scaffKey,
        child: Stack(
          children: <Widget>[
            ImagePikerWidget(
              imageFile: this.imageFile,
              onImageSelected: (File file) {
                setState(() {
                  imageFile = file;
                });
              },
            ),
            // se coloca aqui al AppBar para que no desplace al Container
            // el SideBox es que como esta en un stack se lleva el logo
            // para evitar esto se utiliza el SideBox
            SizedBox(
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(color: Colors.white),
              ),
              height: kToolbarHeight + 25,
            ),
            Center(
              child: Transform.translate(
                offset: Offset(0, -40),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 260, bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 20),
                    child: ListView(
                      //mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: "Usuario:"),
                          onSaved: (value) {
                            userName = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Este campo es obligatorio";
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Contraseña:",
                            suffixIcon: IconButton(
                              icon: Icon(showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                            ),
                          ),
                          obscureText: !showPassword,
                          onSaved: (value) {
                            password = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Este campo es obligatorio";
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Género",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700]),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  RadioListTile(
                                    title: Text(
                                      "Masculino",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    value: Genrer.MALE,
                                    groupValue: genrer,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          genrer = value;
                                        },
                                      );
                                    },
                                  ),
                                  RadioListTile(
                                    title: Text(
                                      "Femenino",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    value: Genrer.FEMALE,
                                    groupValue: genrer,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          genrer = value;
                                        },
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Theme(
                          data: Theme.of(context)
                              .copyWith(accentColor: Colors.white),
                          child: RaisedButton(
                            onPressed: () => _register(context),
                            color: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            textColor: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Registrar"),
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
                        if (_errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              _errorMessage,
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _register(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (imageFile == null) {
        showSnackbar(context, "Seleccione una imágen por favor", Colors.orange);
        return;
      }
      User user = User(
          genrer: this.genrer,
          nickname: this.userName,
          password: this.password,
          photo: this.imageFile);
      final state = await widget.serverController.addUser(user);
      if (state == false) {
        showSnackbar(context, "No se pudo guardar", Colors.orange);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Información"),
              content: Text("Su usuario ha sido registrado exitosamente"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  void showSnackbar(BuildContext context, String title, Color backColor) {
    _scaffKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.center,
        ),
        backgroundColor: backColor,
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:food_flutter_app/screens/Authentication/register.dart';
import 'package:food_flutter_app/services/authentication_services/auth_services.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _height = logicalSize.height;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          color: Theme.of(context).primaryColor),
                      onPressed: () {}),
                  SizedBox(height: 5),
                  Container(
                    child: Text(
                      'FOOD ABANICO UFPS',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32.0,
                          color: Colors.orange),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(2.0),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              child: new Image(
                                width: 300.0,
                                height: 120.0,
                                image:
                                    new AssetImage('assets/images/burger.png'),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (val) => val.isNotEmpty
                            ? null
                            : "please enter a email address",
                        decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (val) =>
                            val.length < 6 ? "Enter more than 6 char" : null,
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.vpn_key),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(height: 20),
                      MaterialButton(
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            print("Email: ${_emailController.text}");
                            print("Email: ${_passwordController.text}");
                            await loginProvider.login(
                                _emailController.text.trim(),
                                _passwordController.text.trim());
                          }
                        },
                        height: 60,
                        minWidth:
                            loginProvider.isLoading ? null : double.infinity,
                        color: Colors.orange,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: loginProvider.isLoading
                            ? CircularProgressIndicator()
                            : Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have  account ?"),
                          SizedBox(width: 5),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()));
                            },
                            child: Text("Register"),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

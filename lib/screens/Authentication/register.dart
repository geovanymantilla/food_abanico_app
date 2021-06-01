import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_flutter_app/services/authentication_services/auth_services.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Register> {
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 100),
                  Text(
                    "Wellcome",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Create account to continue",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: (val) =>
                        val.isNotEmpty ? null : "please enter a email address",
                    decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(height: 30),
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
                  SizedBox(height: 30),
                  MaterialButton(
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        print("Email: ${_emailController.text}");
                        print("Email: ${_passwordController.text}");
                        await loginProvider.register(
                            _emailController.text.trim(),
                            _passwordController.text.trim());
                      }
                    },
                    height: 60,
                    minWidth: loginProvider.isLoading ? null : double.infinity,
                    color: Colors.orange,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: loginProvider.isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            "Registrar",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have  account ?"),
                      SizedBox(width: 5),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Login"),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  if (loginProvider.errorMessage != null)
                    Container(
                      color: Colors.amberAccent,
                      child: ListTile(
                        title: Text(loginProvider.errorMessage),
                        leading: Icon(Icons.error),
                        trailing: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {},
                        ),
                      ),
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

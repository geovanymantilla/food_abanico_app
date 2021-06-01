import 'package:flutter/cupertino.dart';
import 'package:food_flutter_app/screens/Authentication/login.dart';
import 'package:food_flutter_app/screens/Authentication/register.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool isToggle = false;
  void toggleScreen() {
    setState(() {
      isToggle != isToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isToggle) {
      return Register();
    } else {
      return Login();
    }
  }
}

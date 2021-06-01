import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_flutter_app/Food_Delivery/init_home_delivery.dart';
import 'package:food_flutter_app/homeScreens/home_screen.dart';
import 'package:food_flutter_app/screens/Authentication/authentication.dart';
import 'package:food_flutter_app/screens/Authentication/login.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null) {
      return InitHomeDelivery();
    } else {
      return Authentication();
    }
  }
}

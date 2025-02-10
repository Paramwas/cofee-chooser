import 'package:kendrick/screen/authenticate/register.dart';
import 'package:kendrick/screen/authenticate/signin.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignin = true;
  void topes() {
    setState(() {
      showSignin = !showSignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignin) {
      return Signin(toggleView: topes);
    } else {
      return Register(toggleView: topes);
    }
  }
}

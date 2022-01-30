import 'package:cityscope/screens/authenticate/login_screen.dart';
import 'package:cityscope/screens/authenticate/signup_screen.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  final void Function() getAccessToken;

  const AuthenticationScreen({
    Key? key,
    required this.getAccessToken,
  }) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool isSignUpActive = false;

  void toggleSignUpScreen() {
    setState(() {
      isSignUpActive = !isSignUpActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSignUpActive) {
      return SignUpScreen(
          toggle: toggleSignUpScreen, getAccessToken: widget.getAccessToken);
    } else {
      return LoginScreen(
          toggle: toggleSignUpScreen, getAccessToken: widget.getAccessToken);
    }
  }
}

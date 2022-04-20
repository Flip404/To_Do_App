import 'package:first_firebase_project/pages/homepage/widgets/login.dart';
import 'package:first_firebase_project/pages/homepage/widgets/signup.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({ Key? key }) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
    ? LoginWidget(onClickedSignUp: toggle)
    : SignupWidget(onClickedLogIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
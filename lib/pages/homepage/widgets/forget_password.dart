import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_firebase_project/utils.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({ Key? key }) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {

  final _forValidateEmail = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  Future resetPassword() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text);
      Utils.showSnackBar('Password Reset Email Sent');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e){
      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _forValidateEmail,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Image.asset(
                'assets/forgot.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 10),
              const Text(
                "Register",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: "PlayfairDisplay",
                  letterSpacing: 2,
                  color: Color.fromRGBO(105, 190, 224, 1),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailcontroller,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.mail,
                    color: Color.fromRGBO(105, 190, 224, 1),
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(
                      color: Color.fromRGBO(105, 190, 224, 1),
                      fontFamily: "PlayfairDisplay",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                  floatingLabelStyle: TextStyle(
                      color: Color.fromRGBO(105, 190, 224, 0.8),
                      fontFamily: "PlayfairDisplay",
                      fontSize: 14,
                      letterSpacing: 2),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) {
                  if (email != null && !EmailValidator.validate(email)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(105, 190, 224, 1),
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: resetPassword,
                  icon: const Icon(
                    Icons.email_outlined,
                    size: 24,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Reset Password",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
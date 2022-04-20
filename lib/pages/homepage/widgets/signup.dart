import 'package:first_firebase_project/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

class SignupWidget extends StatefulWidget {
  final VoidCallback onClickedLogIn;

  const SignupWidget({Key? key, required this.onClickedLogIn})
      : super(key: key);

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final passwordcontroller1 = TextEditingController();
  final _forValidateEmailPWD = GlobalKey<FormState>();

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  Future signup() async {
    final isValid = _forValidateEmailPWD.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text, password: passwordcontroller.text);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _forValidateEmailPWD,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            Image.asset(
              'assets/register.png',
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
            const SizedBox(height: 10),
            TextFormField(
              controller: passwordcontroller,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.password,
                  color: Color.fromRGBO(105, 190, 224, 1),
                ),
                labelText: "Password",
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
              obscureText: true,
              validator: (pwd) {
                if (pwd != null && pwd.length < 6) {
                  return "Enter min 6 characters";
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: passwordcontroller1,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.password,
                  color: Color.fromRGBO(105, 190, 224, 1),
                ),
                labelText: "Password confirm",
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
              obscureText: true,
              validator: (pwd) {
                if (pwd != null && pwd != passwordcontroller.text) {
                  return "Password must be samed!!";
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(105, 190, 224, 1),
                    minimumSize: const Size.fromHeight(50)),
                onPressed: signup,
                icon: const Icon(
                  Icons.touch_app,
                  size: 32,
                  color: Colors.white,
                ),
                label: const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                )),
            const SizedBox(height: 10),
            RichText(
                text: TextSpan(
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.primary),
                    text: 'Already have an account? ',
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedLogIn,
                      text: 'Log In',
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color.fromRGBO(105, 190, 224, 1),
                      ))
                ]))
          ],
        ),
      ),
    );
  }
}

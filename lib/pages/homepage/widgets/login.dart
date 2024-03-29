import 'package:first_firebase_project/pages/homepage/widgets/forget_password.dart';
import 'package:first_firebase_project/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginWidget({Key? key, required this.onClickedSignUp})
      : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  Future logIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text, password: passwordcontroller.text);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Image.asset(
            'assets/login.png',
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 10),
          const Text(
            "Log In",
            style: TextStyle(
              color: Color.fromRGBO(105, 190, 224, 1),
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: "PlayfairDisplay",
              letterSpacing: 2,
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
            obscureText: true,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(105, 190, 224, 1),
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: logIn,
              icon: const Icon(
                Icons.login,
                size: 32,
                color: Colors.white,
              ),
              label: const Text(
                "Log In",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              )),
          const SizedBox(height: 10),
          GestureDetector(
            child: const Text(
              'Forget Password?',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Color.fromRGBO(105, 190, 224, 1),
                fontSize: 18,
              ),
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ForgetPasswordPage())),
          ),
          const SizedBox(height: 10),
          RichText(
              text: TextSpan(
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.primary),
                  text: 'No account?  ',
                  children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignUp,
                    text: 'Register',
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color.fromRGBO(105, 190, 224, 1),
                    ))
              ]))
        ],
      ),
    );
  }
}

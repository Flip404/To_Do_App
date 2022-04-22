import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_firebase_project/pages/homepage/home_page.dart';
import 'package:first_firebase_project/pages/homepage/widgets/login.dart';
import 'package:first_firebase_project/pages/homepage/widgets/signup.dart';
import 'package:first_firebase_project/provider/todo_provider.dart';
import 'package:first_firebase_project/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => FeaturesProvider(),
        builder: (context, _) {
          final featuresProvider = Provider.of<FeaturesProvider>(context);

          return MaterialApp(
            scaffoldMessengerKey: Utils.messengerKey,
            debugShowCheckedModeBanner: false,
            // showPerformanceOverlay: true,
            title: 'To Do List App',
            themeMode: featuresProvider.mode,
            theme: ThemeData(
              primarySwatch: Colors.grey,
              primaryColor: Colors.white,
              brightness: Brightness.light,
              backgroundColor: const Color(0xFFFFFFFF),
              dividerColor: Colors.white54,
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.grey,
              primaryColor: Colors.black,
              brightness: Brightness.dark,
              backgroundColor: const Color(0x00000000),
              dividerColor: Colors.black12,
            ),
            home: const MainPage(),
          );
        });
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final features = Provider.of<FeaturesProvider>(context);

    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                    color: Color.fromRGBO(105, 190, 224, 1)),
              );
            } else if (snapshot.hasData) {
              return const HomePage();
            } else {
              return features.logSign
                  ? LoginWidget(onClickedSignUp: features.togglLogIn)
                  : SignupWidget(onClickedLogIn: features.togglLogIn);
            }
          }),
    );
  }
}

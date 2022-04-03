import 'package:first_firebase_project/pages/homepage/home_page.dart';
import 'package:first_firebase_project/provider/todo_provider.dart';
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
            // showPerformanceOverlay: true,
            title: 'To Do List App',
            themeMode: featuresProvider.mode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            home: const HomePage(),
          );
        });
  }
}

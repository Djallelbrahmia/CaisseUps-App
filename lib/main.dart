import 'package:caisseapp/firebase_options.dart';
import 'package:caisseapp/screens/home%20screen.dart';
import 'package:caisseapp/screens/login.dart';
import 'package:caisseapp/utils/constants.dart';
import 'package:caisseapp/utils/global_methods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseInitialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print(snapshot.connectionState);
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Color(0xff8FBC8F),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: Text(snapshot.error.toString())),
            ),
          );
        }
        return MaterialApp(
          title: 'Caisse App',
          theme: GlobalMethodes.getThemeData(),
          home: (authInstance.currentUser == null)
              ? const LoginView()
              : const MyHomePage(),
        );
      },
    );
  }
}

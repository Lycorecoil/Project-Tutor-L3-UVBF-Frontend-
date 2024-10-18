import 'package:flutter/material.dart';
import 'package:users_indriver_app/auth/signin_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
             apiKey: "AIzaSyB0qaw8t-bqPePq2mGPAtJXKmIgyCjmnr4",
             authDomain: "driver-d133e.firebaseapp.com",
             databaseURL: "https://driver-d133e-default-rtdb.asia-southeast1.firebasedatabase.app",
             projectId: "driver-d133e",
             storageBucket: "driver-d133e.appspot.com",
             messagingSenderId: "927758497869",
             appId: "1:927758497869:web:79b533121c508af0dc8404"));
  } else {
    await Firebase.initializeApp();
  }

  await Permission.locationWhenInUse.isDenied.then((value) {
    if (value) {
      Permission.locationWhenInUse.request();
    }
  });

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Users App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SignInPage(),
    );
  }
}


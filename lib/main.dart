import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_ajm/view/home.dart';
import 'package:note_ajm/view/login.dart';
import 'controller/notecon.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note',
      theme: ThemeData(useMaterial3: true,
        primarySwatch: Colors.teal,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,AsyncSnapshot<User?> snapshot) {
            if(snapshot.hasData){
              Notecon.email = snapshot.data!.email;
              return Homepage();
            }
            return Login();
          }
      ),
    );
  }
}
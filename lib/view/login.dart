import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_ajm/view/signup.dart';

import '../controller/notecon.dart';
import 'home.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var username = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 250,
                ),
                TextField(
                  style:TextStyle(color: Colors.white),
                  controller: username,
                  decoration: InputDecoration(
                    hintText: "Username",
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  style:TextStyle(color: Colors.white),
                  controller: password,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 90,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text("Sign Up", style: TextStyle(
                          color: Colors.teal
                        ),)),
                    SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                email: username.text, password: password.text)
                                .then((value) {
                              Notecon.email=username.text;
                              final snackBar = SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("Login Successfully"),
                                  duration: Duration(seconds: 2));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Homepage()));
                            });
                          } on Exception catch (e) {
                            String errors = e.toString();
                            final user = errors.contains("user-not-found");
                            final pass = errors.contains("wrong-password");
                            final unkwn = errors.contains("unknown");
                            final emaill = errors.contains("invalid-email");
                            if (user == true) {
                              final snackBar = SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("User Not Found"),
                                  duration: Duration(seconds: 2));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                            if (pass == true) {
                              final snackBar = SnackBar(
                                  backgroundColor: Colors.red,
                                  content:
                                  Text("Email / password does not match"),
                                  duration: Duration(seconds: 2));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                            if (unkwn == true) {
                              final snackBar = SnackBar(
                                  backgroundColor: Colors.red,
                                  content:
                                  Text("Please Enter email and password"),
                                  duration: Duration(seconds: 2));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                            if (emaill == true) {
                              final snackBar = SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Enter a valid email address"),
                                  duration: Duration(seconds: 2));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        },
                        child: Text("Login", style: TextStyle(
                          color: Colors.teal
                        ),)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
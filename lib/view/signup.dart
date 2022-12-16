import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final auth = FirebaseAuth.instance;

  var name = TextEditingController();
  var age = TextEditingController();
  var phonenumber = TextEditingController();
  var username = TextEditingController();
  var pass = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  TextFormField(
                    style:TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Name";
                      }
                      return null;

                    },
                    controller: name,
                    decoration: InputDecoration(
                      hintText: "Name",
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
                    height: 15,
                  ),
                  TextFormField(
                    style:TextStyle(color: Colors.white),
                    controller: age,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Age";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Age",
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
                    height: 15,
                  ),
                  TextFormField(
                    style:TextStyle(color: Colors.white),
                    controller: username,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Username";
                      }
                      return null;
                    },
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
                      ),),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    style:TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Password";
                      }
                      return null;
                    },
                    controller: pass,
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
                      ),),
                  ),
                  SizedBox(height: 40,),
                  ElevatedButton(
                      onPressed: () async {
                        final valid = _formKey.currentState!.validate();
                        if (valid == true) {
                          var userdata =
                          await auth.createUserWithEmailAndPassword(
                              email: username.text, password: pass.text);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                          final snackBar = SnackBar(
                              backgroundColor: Colors.green,
                              content: Text("Sign Up Successfully"),
                              duration: Duration(seconds: 1));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                        } else {
                          return;
                        }
                      },
                      child: Text("Sign Up", style: TextStyle(
                        color: Colors.teal
                      ),))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controller/notecon.dart';
import 'home.dart';

class NewNote extends StatefulWidget {
  QueryDocumentSnapshot? docNew;
  NewNote({
    Key? key,
    this.docNew,
  }) : super(key: key);

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  Postdata() async {
    FirebaseFirestore.instance
        .collection('noteapp')
        .doc('${Notecon.email}')
        .collection('notes')
        .add({
      'title': Notecon.Title.text,
      'subTitle': Notecon.SubTitle.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.width);
    print(size.height);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal,
        title: Text(
          "Create Note",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          MaterialButton(
            minWidth: 40,
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Homepage()));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home),
                // Text("Menu")
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: size.height*.02,
              ),
              Container(
                height: size.height*0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.teal)
                ),
                child: TextField(
                  controller: Notecon.Title,
                  style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Title",
                      hintStyle: TextStyle(color: Colors.teal[200], fontSize: 20)),
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
              SizedBox(
               height: size.height*.02,
              ),
              Container(
                height: size.height*0.64,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.teal)
                ),
                child: TextField(
                  controller: Notecon.SubTitle,
                  style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  decoration: InputDecoration.collapsed(
                      hintText: 'Note',
                      hintStyle: TextStyle(color: Colors.teal[200], fontSize: 20)),
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label:Icon(
          Icons.task_alt,
          color: Colors.black,
        ),
        onPressed: () {
          if (Notecon.Title.text.isNotEmpty) {
            Postdata();
            setState((){
              Notecon.Title.text="";
              Notecon.SubTitle.text="";
            });
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Homepage()));
          } else {
            final snackBar = SnackBar(
                backgroundColor: Colors.red,
                content: Text("notes No add"),
                duration: Duration(seconds: 1));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
      ),
    );
  }
}
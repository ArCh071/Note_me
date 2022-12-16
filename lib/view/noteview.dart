import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controller/notecon.dart';
import 'home.dart';
class NoteView extends StatefulWidget {
  final text;
  final description;
  dynamic id;
  QueryDocumentSnapshot? doc;
  NoteView({Key? key, this.text,this.description,this.id,this.doc,}) : super(key: key);
  @override
  State<NoteView> createState() => _NoteViewState();
}
class _NoteViewState extends State<NoteView> {
  var title = TextEditingController();
  var subtitle = TextEditingController();
  addText(){
    setState((){
      title.text=widget.text.toString();
      subtitle.text=widget.description.toString();
    });
  }
  @override
  initState(){
    super.initState();
    addText();
  }
  Future<dynamic>updateData(id)async{
    FirebaseFirestore.instance.collection("noteapp").doc('${Notecon.email}').collection("notes").doc(id).update({
      "title":title.text,
      "subTitle":subtitle.text,
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:Colors.white,
      appBar:AppBar(
        backgroundColor: Colors.teal,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child:SingleChildScrollView(
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
                    controller: title,
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
                    controller: subtitle,
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Icon(Icons.task_alt,
          color:Colors.black,),
        onPressed: (){
          updateData(widget.id);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homepage()));
        },
      ),
    );
  }
}
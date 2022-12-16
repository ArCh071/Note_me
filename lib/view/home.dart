import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controller/notecon.dart';
import 'login.dart';
import 'newnote.dart';
import 'noteview.dart';
class Homepage extends StatefulWidget {
  final dynamic title;
  final dynamic subtitle;
  Homepage({this.title, this.subtitle});
  @override
  State<Homepage> createState() => _HomepageState();
}
class _HomepageState extends State<Homepage> {
  Future? deletenote(String id) {
    FirebaseFirestore.instance.collection("noteapp").doc('${Notecon.email}').collection("notes").doc(id).delete();
  }
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    final auth = FirebaseAuth.instance;
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        elevation: 0,
        title: Text(
          "My Notes",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
        ),
        actions: [
          ElevatedButton(
              onPressed: () async {
                Notecon.email='';
                await auth.signOut().then((value) => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login())));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
                elevation: 0// background
              ),
              child: Text("Logout", style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold
              ),)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("noteapp").doc('${Notecon.email}').collection("notes").snapshots(),
                  builder: (context, AsyncSnapshot snapshop) {
                    if (snapshop.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshop.data.docs.length,
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot data =
                            snapshop.data.docs[index];
                            return Dismissible(
                                key: Key(data.id),
                                background: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )
                                      ],
                                    )),
                                onDismissed: (direction) async {
                                  await deletenote(
                                      snapshop.data.docs[index].id);
                                },
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => NoteView(
                                                text: data["title"].toString(), description: data["subTitle"].toString(), id: snapshop.data.docs[index].id, doc: data,)));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: double.infinity,
                                        height: size.height*.150,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data["title"].toString(),
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                    TextOverflow.ellipsis),
                                              ),
                                              Text(
                                                data["subTitle"].toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    overflow:
                                                    TextOverflow.ellipsis),
                                              ),
                                            ],
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(10)),
                                      ),
                                    )));
                          });
                    }
                  }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(elevation: 0,
        label:Icon(
          Icons.add_circle,
          color: Colors.black,
          size: 50,
        ),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => NewNote()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
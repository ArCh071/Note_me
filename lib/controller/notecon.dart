import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_ajm/view/home.dart';
import 'package:note_ajm/view/newnote.dart';
import 'package:note_ajm/view/noteview.dart';

class Notecon{
  static TextEditingController  Title = TextEditingController();
  static TextEditingController SubTitle = TextEditingController();
  static dynamic email;
}
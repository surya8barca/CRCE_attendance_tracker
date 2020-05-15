import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crce_attendance_tracker/bodyloading.dart';
import 'package:flutter/material.dart';

class TheorySubjects extends StatefulWidget {
  @override
  _TheorySubjectsState createState() => _TheorySubjectsState();
}

class _TheorySubjectsState extends State<TheorySubjects> {
  bool dataloaded = false;

  Future<void> gettheorysubjects() async {
    try {
      final CollectionReference theorysubjects =
          Firestore.instance.collection('Theory Subjects');
      QuerySnapshot alltheorysubjects = await theorysubjects.getDocuments();
      for (int i = 0; i < alltheorysubjects.documents.length; i++) {
        print(alltheorysubjects.documents[i].data);
      }
      setState(() {
        dataloaded = true;
      });
    } catch (e) {
      print(e.message);
    }
  }

  @override
  void initState() {
    gettheorysubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!dataloaded) {
      return BodyLoading();
    } else {
      return SingleChildScrollView(
        child: Container(
          child: Text('theory'),
        ),
      );
    }
  }
}

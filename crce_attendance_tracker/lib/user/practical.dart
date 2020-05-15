import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crce_attendance_tracker/bodyloading.dart';
import 'package:flutter/material.dart';

class PracticalSubjects extends StatefulWidget {
  @override
  _PracticalSubjectsState createState() => _PracticalSubjectsState();
}

class _PracticalSubjectsState extends State<PracticalSubjects> {
  bool dataloaded = false;
  Future<void> getpracticalsubjects() async {
    try {
      final CollectionReference practicalsubjects =
          Firestore.instance.collection('Practical Subjects');
      QuerySnapshot allpracticalsubjects =
          await practicalsubjects.getDocuments();
      for (int i = 0; i < allpracticalsubjects.documents.length; i++) {
        print(allpracticalsubjects.documents[i].data);
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
    getpracticalsubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!dataloaded) {
      return BodyLoading();
    } else {
      return SingleChildScrollView(
        child: Container(
          child: Text('practical'),
        ),
      );
    }
  }
}

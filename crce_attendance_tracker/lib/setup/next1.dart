import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crce_attendance_tracker/setup/next2.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Next1 extends StatefulWidget {
  final int totalTheorySubjects, totalPracticalSubjects;
  Next1({this.totalTheorySubjects, this.totalPracticalSubjects});

  @override
  _Next1State createState() => _Next1State();
}

class _Next1State extends State<Next1> {
  final snackbar = SnackBar(
    content: Text(
      'Subject Added',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20, color: Colors.white),
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.blue,
    duration: Duration(seconds: 2),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Colors.blue,
        )),
  );

  String subjectName;
  int totalLectures = 0, attended = 0, attendance = 0;

  Future<bool> addTheorySubject() async {
    final CollectionReference theorySubjects =
        Firestore.instance.collection('Theory Subjects');
    final snapShot = await theorySubjects.document(subjectName).get();
    if (snapShot.exists) {
      Alert(
              context: context,
              title: 'Subject Already Added',
              buttons: [],
              style: AlertStyle(backgroundColor: Colors.cyan))
          .show();
      return false;
    } else {
      theorySubjects.document(subjectName).setData({
        'name_of_subject': subjectName,
        'total_lectures': totalLectures,
        'lectures_attended': attended,
        'attendance': attendance,
      });
      setState(() {
        subjectName = null;
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text(
          'Setup',
          style: TextStyle(
            fontSize: 28.0,
            color: Colors.black,
          ),
        ),
      ),
      body: Builder(
          builder: (context) => SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Enter Details of Theory Subjects',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  for (int i = 0;
                                      i < widget.totalTheorySubjects;
                                      i++)
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                'Subject ${i + 1}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 23,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              TextField(
                                                maxLength: 30,
                                                maxLengthEnforced: true,
                                                enableSuggestions: true,
                                                textCapitalization:
                                                    TextCapitalization.words,
                                                style: TextStyle(
                                                    color: Colors.yellow,
                                                    fontSize: 25),
                                                autocorrect: true,
                                                textInputAction:
                                                    TextInputAction.next,
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide: BorderSide(
                                                        color: Colors.black,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.black,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    labelText:
                                                        'Name of Subject:',
                                                    labelStyle: TextStyle(
                                                      color: Colors.orange,
                                                    ),
                                                    helperText: '*required',
                                                    helperStyle: TextStyle(
                                                        color: Colors.red)),
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    setState(() {
                                                      subjectName = value;
                                                    });
                                                  }
                                                },
                                                onSubmitted: (value) {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                              ),
                                              SizedBox(height: 10),
                                              FlatButton(
                                                padding: EdgeInsets.all(15),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                onPressed: () async {
                                                  if (subjectName != null &&
                                                      subjectName != '') {
                                                    bool result =
                                                        await addTheorySubject();
                                                    if (result) {
                                                      Scaffold.of(context)
                                                          .showSnackBar(
                                                              snackbar);
                                                    }
                                                  } 
                                                  else {
                                                    Alert(
                                                            context: context,
                                                            title:
                                                                'Enter name of Subject $i',
                                                            buttons: [],
                                                            style: AlertStyle(
                                                                backgroundColor:
                                                                    Colors
                                                                        .cyan))
                                                        .show();
                                                  }
                                                },
                                                color: Colors.blue,
                                                child: Text(
                                                  'Add Subject',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 25,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                ],
                              )),
                          FlatButton(
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Next2(
                                          totalPracticalSubjects:
                                              widget.totalPracticalSubjects)));
                            },
                            color: Colors.blue,
                            child: Text(
                              'Next',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ])),
              )),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crce_attendance_tracker/setup/next1.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  String name, branch;
  int rollno, semester, practicalSubjects, theorySubjects;
  double attendance = 0;

  validation() {
    if (name == null ||
        branch == null ||
        rollno.toString() == null ||
        semester.toString() == null ||
        practicalSubjects.toString() == null ||
        theorySubjects.toString() == null ||
        name == '' ||
        branch == '') {
      Alert(
              context: context,
              title: 'All fields are required',
              buttons: [],
              style: AlertStyle(backgroundColor: Colors.cyan))
          .show();
      return false;
    } else if (semester > 8 || semester < 1) {
      Alert(
              context: context,
              title: 'Invalid semester',
              desc: 'Semester must be between 1 and 8',
              buttons: [],
              style: AlertStyle(backgroundColor: Colors.cyan))
          .show();
      return false;
    } else if (theorySubjects + practicalSubjects == 0) {
      Alert(
              context: context,
              title: 'Invalid input',
              desc: 'Theory subjects and Practical Subjects both can not be 0',
              buttons: [],
              style: AlertStyle(backgroundColor: Colors.cyan))
          .show();
      return false;
    } else {
      return true;
    }
  }

  //adding to database
  Future<void> adduserdetails() async {
    final CollectionReference database = Firestore.instance.collection('Database');
    try{
      database.document('User Details').setData({
        'name':name,
        'roll_no':rollno,
        'branch':branch,
        'sem':semester,
        'total_theory_subjects':theorySubjects,
        'total_practical_subjects':practicalSubjects,
        'attendance':attendance,
      });
    } 
    catch(e){
      print(e.message);
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
                            'Enter User Details',
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
                            padding: EdgeInsets.all(15),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 2),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                TextField(
                                  maxLength: 30,
                                  maxLengthEnforced: true,
                                  enableSuggestions: true,
                                  textCapitalization: TextCapitalization.words,
                                  style: TextStyle(
                                      color: Colors.yellow, fontSize: 25),
                                  autocorrect: true,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      labelText: 'Name:',
                                      labelStyle: TextStyle(
                                        color: Colors.orange,
                                      ),
                                      helperText: '*required',
                                      helperStyle:
                                          TextStyle(color: Colors.red)),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        name = value;
                                      });
                                    }
                                  },
                                  onSubmitted: (value) {
                                    FocusScope.of(context).nextFocus();
                                  },
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  maxLength: 5,
                                  maxLengthEnforced: true,
                                  enableSuggestions: true,
                                  keyboardType: TextInputType.number,
                                  textCapitalization: TextCapitalization.words,
                                  style: TextStyle(
                                      color: Colors.yellow, fontSize: 25),
                                  autocorrect: true,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      labelText: 'Roll Number:',
                                      labelStyle: TextStyle(
                                        color: Colors.orange,
                                      ),
                                      helperText: '*required',
                                      helperStyle:
                                          TextStyle(color: Colors.red)),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        rollno = int.parse(value);
                                      });
                                    }
                                  },
                                  onSubmitted: (value) {
                                    FocusScope.of(context).nextFocus();
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  maxLength: 20,
                                  maxLengthEnforced: true,
                                  enableSuggestions: true,
                                  textCapitalization: TextCapitalization.words,
                                  style: TextStyle(
                                      color: Colors.yellow, fontSize: 25),
                                  autocorrect: true,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Colors.yellow,
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.yellow,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      labelText: 'Branch:',
                                      labelStyle: TextStyle(
                                        color: Colors.orange,
                                      ),
                                      helperText: '*required',
                                      helperStyle:
                                          TextStyle(color: Colors.red)),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        branch = value;
                                      });
                                    }
                                  },
                                  onSubmitted: (value) {
                                    FocusScope.of(context).nextFocus();
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  maxLength: 5,
                                  maxLengthEnforced: true,
                                  enableSuggestions: true,
                                  keyboardType: TextInputType.number,
                                  textCapitalization: TextCapitalization.words,
                                  style: TextStyle(
                                      color: Colors.yellow, fontSize: 25),
                                  autocorrect: true,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      labelText: 'Semester:',
                                      labelStyle: TextStyle(
                                        color: Colors.orange,
                                      ),
                                      helperText: '*required',
                                      helperStyle:
                                          TextStyle(color: Colors.red)),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        semester = int.parse(value);
                                      });
                                    }
                                  },
                                  onSubmitted: (value) {
                                    FocusScope.of(context).nextFocus();
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Enter Course Details',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  maxLengthEnforced: true,
                                  enableSuggestions: true,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      color: Colors.yellow, fontSize: 25),
                                  autocorrect: true,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      labelText: 'Number of Theory Subjects:',
                                      labelStyle: TextStyle(
                                        color: Colors.orange,
                                      ),
                                      helperText: '*required',
                                      helperStyle:
                                          TextStyle(color: Colors.red)),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        theorySubjects = int.parse(value);
                                      });
                                    }
                                  },
                                  onSubmitted: (value) {
                                    FocusScope.of(context).nextFocus();
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  maxLengthEnforced: true,
                                  enableSuggestions: true,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      color: Colors.yellow, fontSize: 25),
                                  autocorrect: true,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      labelText:
                                          'Number of Practical Subjects:',
                                      labelStyle: TextStyle(
                                        color: Colors.orange,
                                      ),
                                      helperText: '*required',
                                      helperStyle:
                                          TextStyle(color: Colors.red)),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        practicalSubjects = int.parse(value);
                                      });
                                    }
                                  },
                                  onSubmitted: (value) {
                                    FocusScope.of(context).nextFocus();
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15,),
                          FlatButton(
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () async{
                              if (validation()) {
                                await adduserdetails();
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Next1(totalTheorySubjects: theorySubjects),));
                              }
                              else{
                                print('error');
                              }
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
                          SizedBox(height: 15,),
                        ])))));
  }
}

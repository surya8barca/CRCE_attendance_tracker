import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crce_attendance_tracker/bodyloading.dart';
import 'package:flutter/material.dart';

class PracticalSubjects extends StatefulWidget {
  @override
  _PracticalSubjectsState createState() => _PracticalSubjectsState();
}

class _PracticalSubjectsState extends State<PracticalSubjects> {
  bool dataloaded = false;
  QuerySnapshot allpracticalsubjects;
  Future<void> getpracticalsubjects() async {
    try {
      final CollectionReference practicalsubjects =
          Firestore.instance.collection('Practical Subjects');
      QuerySnapshot result = await practicalsubjects.getDocuments();
      setState(() {
        allpracticalsubjects = result;
      });
      for (int i = 0; i < result.documents.length; i++) {
        print(result.documents[i].data);
        if (result.documents[i].data["attendance"] < 75) {
          setState(() {
            attendanceColor = Colors.red;
            alert = 'Attendance below required (75%)';
          });
        }
      }
      setState(() {
        dataloaded = true;
      });
    } catch (e) {
      print(e.message);
    }
  }

  Color attendanceColor = Colors.green;
  String alert = 'Attendance above required (75%)';

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
      return Builder(
          builder: (context) => SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Practical Subjects',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.solid,
                            color: Colors.black,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          for (int i = 0;
                              i < allpracticalsubjects.documents.length;
                              i++)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Center(
                                        child: Text(
                                          allpracticalsubjects.documents[i]
                                              .data["name_of_subject"],
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Total Lectures: ${allpracticalsubjects.documents[i].data["total_lectures"].toString()}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Lectures Attended: ${allpracticalsubjects.documents[i].data["lectures_attended"].toString()}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Center(
                                        child: Text(
                                          'Current Attendance',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: attendanceColor,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Center(
                                        child: Text(
                                          '${allpracticalsubjects.documents[i].data["attendance"].toString()} %',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: attendanceColor,
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        alert,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: attendanceColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
    }
  }
}

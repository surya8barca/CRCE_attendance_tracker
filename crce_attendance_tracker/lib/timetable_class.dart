
import 'package:crce_attendance_tracker/subjects_class.dart';

class Timetable{

  String name;
  int rollno;
  String branch;
  String semester;
  int noOfTheorySubjects;
  int noOfPracticalSubjects;

  Timetable({this.name,this.rollno,this.branch,this.semester,this.noOfTheorySubjects,this.noOfPracticalSubjects});

  gettheorySubjects(){
    List<Subject> theorySubjects =[];
    for(int i =0;i<noOfTheorySubjects;i++){
      Subject s =new Subject(
        nameOfSubject: nameofSubject,
        totalLectures: totalLectures,
        attended: attended,

      );
      theorySubjects.add(s);
    }  
    return theorySubjects;
  }

  getpracticalSubjects(){
    List<Subject> practicalSubjects =[];
    for(int i =0;i<noOfPracticalSubjects;i++){
      Subject s =new Subject(
        nameOfSubject: nameofSubject,
        totalLectures: totalLectures,
        attended: attended,
      );
      practicalSubjects.add(s);
    }  
    return practicalSubjects;
  }
  
  

  
}
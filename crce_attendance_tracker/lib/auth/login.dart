import 'package:crce_attendance_tracker/auth/registration.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email,password;
  TextEditingController txt1 = new TextEditingController();
  TextEditingController txt2 = new TextEditingController();



  bool notEmptyField(){
    if((email==null)||(password==null)||(email=='')||(password==''))
    {
      return false;
    }
    else
    {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Attendance Tracker',
          style: TextStyle(
            fontSize: 28.0,
            color: Colors.blue,
          ),
        ),
      ),
      body: Builder(builder: (context)=>
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                  'login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                    controller: txt1,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      labelText: 'Email Address:',
                      labelStyle: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 25.0,
                      )
                    ),
                    onChanged: (value){
                      if(value!=null)
                      {
                        setState(() {
                        email=value; //user input saved in variable id
                      });
                      }
                    },
                    onFieldSubmitted: (value) => FocusScope.of(context).nextFocus(),
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    controller: txt2,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                      labelText: 'Password:',
                      labelStyle: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 25.0,
                      )
                    ),
                    onChanged: (value){
                      if(value!=null)
                      {
                        setState(() {
                        password=value; //user input saved in variable id
                      });
                      }
                    },
                    onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
                  ),
                  SizedBox(height: 30.0,),
                  RaisedButton(
                    padding: EdgeInsets.all(10),
                    color: Colors.cyan,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30)),
                    onPressed: () async {
                      if(notEmptyField())
                      {
                        //login into the database
                        //access the documents
                        //push replacement to UserHome with uid
                      }
                      else
                      {
                        Alert(context: context, title: 'Empty Fields',desc: "Please Enter ID and Password",buttons: []).show();
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            ],
                ),
              ),
              SizedBox(height: 30,),
              Text(
                  'Still not a user?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20,),
                RaisedButton(
                    padding: EdgeInsets.all(10),
                    color: Colors.cyan,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30)),
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Registration()));
                    },
                    child: Text(
                      'Register Here',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            ],
          ),
          
        ),
      ),
      ),
    );
  }
}
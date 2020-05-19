import 'package:crce_attendance_tracker/auth/registration.dart';
import 'package:crce_attendance_tracker/user/userhome.dart';
import 'package:crce_attendance_tracker/userclass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool rememberme=true;
  String email, password;
  TextEditingController txt1 = new TextEditingController();
  TextEditingController txt2 = new TextEditingController();

  bool notEmptyField() {
    if ((email == null) ||
        (password == null) ||
        (email == '') ||
        (password == '')) {
      return false;
    } else {
      return true;
    }
  }

  final userbox = Hive.box('currentuser');

  Future<bool> login() async {
    try {
      AuthResult result =await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
          if(rememberme)
          {
            print('hive adding');
            await userbox.add(User(result.user));
            print('added in hive');
          }
      return true;
    } catch (e) {
      Alert(
          context: context,
          title: 'Login Error',
          desc: e.message,
          buttons: []).show();
      return false;
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
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/back.jpg'),
                    fit: BoxFit.cover,
                    ),
                ),
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    color: Colors.yellow,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
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
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            labelStyle: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 25.0,
                            )),
                            style: TextStyle(color: Colors.blue,fontSize: 20),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              email = value; 
                            });
                          }
                        },
                        onFieldSubmitted: (value) =>
                            FocusScope.of(context).nextFocus(),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.blue,fontSize: 20),
                        controller: txt2,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            labelText: 'Password:',
                            labelStyle: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 25.0,
                            )),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              password =
                                  value; //user input saved in variable id
                            });
                          }
                        },
                        onFieldSubmitted: (value) =>
                            FocusScope.of(context).unfocus(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Checkbox(
                            value: rememberme,
                            checkColor: Colors.white,
                            autofocus: true,
                            focusColor: Colors.blue,
                            activeColor: Colors.blue,
                            hoverColor: Colors.blue,
                            onChanged: (value) {
                              setState(() {
                                rememberme=value;
                              });
                            },
                            ),
                            Text(
                              'Keep me Logged In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      RaisedButton(
                        padding: EdgeInsets.all(10),
                        color: Colors.cyan,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () async {
                          if (notEmptyField()) {
                            if (await login()) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserHome()));
                            }
                          } else {
                            Alert(
                                context: context,
                                title: 'Empty Fields',
                                desc: "Please Enter ID and Password",
                                buttons: []).show();
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
                SizedBox(
                  height: 30,
                ),
                Divider(
                  height: 5.0,
                  thickness: 2.0,
                  color: Colors.blueAccent,
                  indent: 30.0,
                  endIndent: 30.0,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Still not a user?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  padding: EdgeInsets.all(10),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Registration()));
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

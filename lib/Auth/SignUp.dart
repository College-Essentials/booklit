import 'package:booklit/Auth/Login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:booklit/Navigation.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  DatabaseReference users;
  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    users = database.reference().child('users');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
          body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/loginbackdrop.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'BookLit',
                      style: TextStyle(
                          color: Color.fromRGBO(255, 204, 0, 1),
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              validator: (input) {
                                if (input.isEmpty) {
                                  return 'Provide an Email';
                                }
                                if (!input.contains('@calstatela.edu')) {
                                  return 'Calstate LA email ID is requered to sign-up';
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  filled: true,
                                  fillColor: Color.fromRGBO(226, 216, 216, .65),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)))),
                              onSaved: (input) => _email = input,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 10),
                            child: TextFormField(
                              validator: (input) {
                                if (input.length < 6) {
                                  return 'Password has to be atleast 6 characters';
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  filled: true,
                                  fillColor: Color.fromRGBO(226, 216, 216, .65),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)))),
                              onSaved: (input) => _password = input,
                              obscureText: true,
                            ),
                          ),
                          RaisedButton(
                            onPressed: signUp,
                            color: Color.fromRGBO(255, 204, 0, 1),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Have an account?",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Login()));
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(255, 204, 0, 1),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ), //column for form
                    ),
                  ],
                ),
              ))),
    );
  }

  void signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Navigation()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}

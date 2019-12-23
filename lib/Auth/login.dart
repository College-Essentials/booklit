import 'package:booklit/Auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:booklit/Navigation.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'BookLit',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'For Students By Students',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontStyle: FontStyle.italic),
              ),
              ButtonTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20)),
                child: RaisedButton(
                  onPressed: () {
                    signInWithGoogle().whenComplete(() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Navigation();
                          },
                        ),
                      );
                    });
                  },
                  color: Colors.yellow,
                  child: Text('Login with Google'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

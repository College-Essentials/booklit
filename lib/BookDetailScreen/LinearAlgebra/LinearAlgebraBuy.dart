import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'LinearAlgebraSell.dart';
import 'package:flutter/material.dart';

class LinearAlgebraBuy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LinearAlgebraBuyState();
  }
}

class _LinearAlgebraBuyState extends State<LinearAlgebraBuy> {
  List<LinearSellersList> linearBook = List();
  LinearSellersList book;
  DatabaseReference bookRef;

  @override
  void initState() {
    super.initState();
    book = LinearSellersList("", "");
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    bookRef = database.reference().child('linearSellers');
    bookRef.onChildAdded.listen(_onEntryAdded);
    bookRef.onChildChanged.listen(_onEntryChanged);
  }

  _onEntryAdded(Event event) {
    setState(() {
      linearBook.add(LinearSellersList.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = linearBook.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      linearBook[linearBook.indexOf(old)] =
          LinearSellersList.fromSnapshot(event.snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double c_width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
              flex: 0,
              child: Column(
                children: <Widget>[
                  AspectRatio(
                      aspectRatio: 3 / 2,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: c_width,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Image.asset(
                                      'assets/images/linear_algebra.jpg',
                                      scale: 3.5,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  'Introduction to\nLinear Algebra\n',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          TextSpan(
                                              text: '5th Edition\n',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18)),
                                          TextSpan(
                                              text: 'Gilbert Strang',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 18)),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              ButtonBar(
                                alignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RaisedButton(
                                    elevation: 5,
                                    onPressed: _openPDF,
                                    color: Color.fromRGBO(255, 204, 0, 1),
                                    child: Text('Open PDF'),
                                  ),
                                  RaisedButton(
                                    elevation: 5,
                                    onPressed: _sendPDF,
                                    color: Color.fromRGBO(255, 204, 0, 1),
                                    child: Text('Send PDF'),
                                  ),
                                ],
                              ),
                              Text(
                                'Relevent Courses: Math 2550',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Divider(
                    color: Colors.black,
                    thickness: .5,
                  ),
                  Text(
                    'On-Campus Sellers',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  )
                ],
              )),
          Flexible(
              child: FirebaseAnimatedList(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  query: bookRef,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    return new Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Card(
                          color: Color.fromRGBO(255, 236, 179, 1),
                          child: ListTile(
                            leading: Icon(
                              Icons.account_circle,
                              color: Colors.black,
                              size: 50,
                            ),
                            title: Text('Name: ' + linearBook[index].userName),
                            subtitle: Text('Contact Info: ' +
                                linearBook[index].contactInfo),
                          ),
                        ));
                  })),
        ],
      ),
    ));
  }

  _openPDF() async {
    const url =
        'https://drive.google.com/open?id=1feJ2AjVBPz_oPHp9Z7ySAw06enJ22jhA';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _sendPDF() async {
    const url =
        'mailto:?subject=Your Linear Algebra Textbook&body=https://drive.google.com/open?id=1feJ2AjVBPz_oPHp9Z7ySAw06enJ22jhA';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

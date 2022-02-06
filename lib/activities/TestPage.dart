import 'package:moodbasemedia/activities/home.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TestPage'),
      ),
      body: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('TestPage Coming soon',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Home()),
                    // );
                  },
                  child: Text("Back to login"),
                ),
              ),
            ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import './recordlist.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return HomeState();
  }
}

class HomeState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
            appBar: AppBar(
                title: Text('Flutter Engine')
            ),
            body: Center(
                child: Column(
                  children: <Widget>[
                    FlatButton(onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> RecordListWidget()));
                    }, child: Text('Record List'))
                  ],
                )
            )
    );
  }
}
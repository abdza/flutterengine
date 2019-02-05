import 'package:flutter/material.dart';

class RecordListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return RecordListState();
  }
}

class RecordListState extends State<RecordListWidget> {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: Text('Flutter Engine')
            ),
            body: Center(
                child: Text('Record List')
            )
        )
    );
  }
}
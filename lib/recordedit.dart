import 'package:flutter/material.dart';

class RecordEditWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return RecordEditState();
  }
}

class RecordEditState extends State<RecordEditWidget> {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: Text('Flutter Engine')
            ),
            body: Center(
                child: Text('Record Edit')
            )
        )
    );
  }
}
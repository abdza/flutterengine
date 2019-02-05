import 'package:flutter/material.dart';

class RecordViewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return RecordViewState();
  }
}

class RecordViewState extends State<RecordViewWidget> {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: Text('Flutter Engine')
            ),
            body: Center(
                child: Text('Record View')
            )
        )
    );
  }
}
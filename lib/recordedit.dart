import 'package:flutter/material.dart';

class RecordEditWidget extends StatefulWidget {

  final item;

  RecordEditWidget(this.item);

  @override
  State<StatefulWidget> createState(){
    return RecordEditState(this.item);
  }
}

class RecordEditState extends State<RecordEditWidget> {

  final item;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  RecordEditState(this.item);

  @override
  Widget build(BuildContext context){
    return Scaffold(
            appBar: AppBar(
                title: Text('Flutter Engine'),
                actions: <Widget>[
                  IconButton(
                  icon: Icon(Icons.done),
                  onPressed: (){
                    Navigator.pop(context);
                  }
                  ),
                ]
            ),
            body: Form(
              key: _formKey,
              autovalidate: false,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.label),
                    title: TextFormField(
                      decoration: new InputDecoration(
                        hintText: "Name",
                      ),
                      initialValue: this.item['name'],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.description),
                    title: TextFormField(
                      decoration: new InputDecoration(
                        hintText: "Description",
                      ),
                      initialValue: this.item['desc'],
                    ),
                  )
                ],
              ),
            )
    );
  }
}
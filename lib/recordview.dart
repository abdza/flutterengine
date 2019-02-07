import 'package:flutter/material.dart';
import './recordedit.dart';

class RecordViewWidget extends StatefulWidget {

  final item;

  RecordViewWidget(this.item);

  @override
  State<StatefulWidget> createState(){
    return RecordViewState(this.item);
  }
}

class RecordViewState extends State<RecordViewWidget> {

  final item;

  RecordViewState(this.item);

  @override
  Widget build(BuildContext context){
    return Scaffold(
            appBar: AppBar(
                title: Text('Flutter Engine'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> RecordEditWidget(this.item)));
                  },
                )
              ],
            ),
            body: ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Name'),
                  subtitle: Text(this.item['name']),
                ),
                ListTile(
                  title: Text('Description'),
                  subtitle: Text(this.item['desc']),
                )
              ],
            )
    );
  }
}
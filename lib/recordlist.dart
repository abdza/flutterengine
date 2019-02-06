import 'package:flutter/material.dart';
import './recordview.dart';

class RecordListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return RecordListState();
  }
}

class RecordListState extends State<RecordListWidget> {

  var items = [
    {'name':'Namaku','desc':'Desc ku'},
    {'name':'Namaku 2','desc':'Desc ku 2'},
    {'name':'Namaku 3','desc':'Desc ku 3'}
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
            appBar: AppBar(
                title: Text('Flutter Engine')
            ),
            body: Center(
                child: ListView.builder(
                  itemCount: this.items !=null ? this.items.length : 0,
                  itemBuilder: (context, i){
                    final curitem = this.items[i];
                    return ListTile(
                      title: Text(curitem['name']),
                      subtitle: Text(curitem['desc']),
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> RecordViewWidget(curitem)));
                      },
                    );
                  }
            )
        )
    );
  }
}
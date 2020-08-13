import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(children: <Widget>[
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('../../as'),
                ),
                title: Text('Sun'),
              ),
            ),
          ),
        ],)
      ),
    );
  }
}

void productos(){

}
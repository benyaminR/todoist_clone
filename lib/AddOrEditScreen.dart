import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddOrEditScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AddOrEdit"),
      ),
      body: Text("AddOrEditScreen"),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: null,
      ),
    );
  }

}
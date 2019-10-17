


import 'package:flutter/cupertino.dart';

class ProjectBloc with ChangeNotifier{

  String _name;
  String get name=> _name;
  set name(String val){
    _name = val;
    notifyListeners();
  }

  Color _color;
  Color get color=> _color;
  set color(Color val){
    _color = val;
    notifyListeners();
  }
}
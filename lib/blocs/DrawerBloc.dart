

import 'package:flutter/cupertino.dart';

class DrawerBloc with ChangeNotifier{
  String _list = "Inbox";
  String get list => _list;
  set list(String val){
    _list = val;
    notifyListeners();
  }
}
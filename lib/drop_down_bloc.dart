import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class DropDownBloc<T>{
  final textController = TextEditingController();
  final selected$ = BehaviorSubject<T>();

  DropDownBloc({T seedValue}){
    selected$.add(seedValue);
  }

  void dispose(){
    selected$.close();
    textController.dispose();
  }
}
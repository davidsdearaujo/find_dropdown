import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class FindDropdownBloc<T>{
  final textController = TextEditingController();
  final selected$ = BehaviorSubject<T>();

  FindDropdownBloc({T seedValue}){
    selected$.add(seedValue);
  }

  void dispose(){
    selected$.close();
    textController.dispose();
  }
}
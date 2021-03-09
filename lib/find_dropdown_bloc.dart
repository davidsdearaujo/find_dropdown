import 'rxdart/behavior_subject.dart';
import 'package:flutter/material.dart';

class FindDropdownBloc<T> {
  final textController = TextEditingController();
  final selected$ = BehaviorSubject<T>();
  // final _validateMessage$ = BehaviorSubject<String>();

  late Stream<String?> validateMessageOut;

  FindDropdownBloc({T? seedValue, String? Function(T selected)? validate}) {
    if (seedValue != null) selected$.add(seedValue);
    if (validate != null) validateMessageOut = selected$.distinct().map(validate).distinct();
  }

  void dispose() async {
    textController.dispose();
    selected$.close();
  }
}

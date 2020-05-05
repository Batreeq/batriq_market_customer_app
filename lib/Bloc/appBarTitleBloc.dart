import 'dart:async';
import 'package:customerapp/DataLayer/Menu.dart';

import 'bloc.dart';

class appBarBloc extends Bloc {
  String _title;
  String get selectTitle => _title;
  // 1
  final _titleController = StreamController<String>();
  // 2
  Stream<String> get titleStream => _titleController.stream;
  // 3
  void setTitle(String title) {
    _title = title;
    _titleController.sink.add(title);
  }

  // 4
  @override
  void dispose() {
    _titleController.close();
  }
}

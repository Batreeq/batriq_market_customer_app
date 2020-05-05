import 'dart:async';

import 'package:customerapp/Bloc/bloc.dart';

class ProductItemBloc extends Bloc {
  List<String> _count;
  List<String> get selectedMenu => _count;
  // 1
  final _countController = StreamController<List<String>>.broadcast();
  // 2
  Stream<List<String>> get countStream => _countController.stream;
  // 3
  void setCount(List<String> count) {
    _count = count;
    _countController.sink.add(count);
  }

  // 4
  @override
  void dispose() {
    _countController.close();
  }
}

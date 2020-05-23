import 'dart:async';
import 'package:customerapp/models/UserCarts.dart';

import 'bloc.dart';

class CartDataBloc implements Bloc {
  final _controller = StreamController<List<Cart>>();
  Stream<List<Cart>> get cartDataStream => _controller.stream;

  @override
  void dispose() {
    _controller.close();
  }
}
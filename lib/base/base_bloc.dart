import 'dart:async';

import 'package:dartpad_code_mobile/base/base_event.dart';
import 'package:dartpad_code_mobile/share/model/result.dart';
import 'package:flutter/foundation.dart';

abstract class BaseBloc {
  final StreamController<BaseEvent> _eventStreamController =
      StreamController<BaseEvent>();
  Sink<BaseEvent> get event => _eventStreamController.sink;
  final StreamController<Result> _resultStreamController =
      StreamController<Result>();

  Stream<Result> get resultStream => _resultStreamController.stream;
  Sink<Result> get resultSink => _resultStreamController.sink;
  BaseBloc() {
    _eventStreamController.stream.listen((event) {
      dispathEvent(event);
    });
  }

  void dispathEvent(BaseEvent event);

  @mustCallSuper
  void dispose() {
    _eventStreamController.close();
    _resultStreamController.close();
  }
}

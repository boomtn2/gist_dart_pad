import 'package:dartpad_code_mobile/base/base_event.dart';

class EventDeleteGist extends BaseEvent {
  String id;
  EventDeleteGist({
    required this.id,
  });
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartpad_code_mobile/base/base_event.dart';
import 'package:dartpad_code_mobile/share/model/gist.dart';

class EventUpdateGist extends BaseEvent {
  Gist gist;
  EventUpdateGist({
    required this.gist,
  });
}

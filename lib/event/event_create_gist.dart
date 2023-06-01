// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartpad_code_mobile/base/base_event.dart';
import 'package:dartpad_code_mobile/share/model/gist.dart';

class EventCreateGist extends BaseEvent {
  final Gist gist;
  EventCreateGist({
    required this.gist,
  });
}

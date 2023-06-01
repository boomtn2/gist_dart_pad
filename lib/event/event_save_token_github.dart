// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartpad_code_mobile/base/base_event.dart';
import 'package:dartpad_code_mobile/share/model/account_github.dart';

class EventSaveToken extends BaseEvent {
  AccountGitHub github;
  EventSaveToken({
    required this.github,
  });
}

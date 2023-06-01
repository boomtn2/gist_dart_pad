// ignore_for_file: public_member_api_docs, sort_constructors_first
class Result {
  bool isOK;
  String message;
  Result({
    required this.isOK,
    required String msg,
  }) : message = msg;
}

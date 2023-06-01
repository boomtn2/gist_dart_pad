import 'package:flutter/material.dart';

showSnackBar(
    {required BuildContext context,
    required String title,
    required Color background}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(backgroundColor: background, content: Text(title)),
  );
}

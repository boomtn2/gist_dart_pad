import 'package:flutter/material.dart';

class TextFiedlWidget extends StatelessWidget {
  const TextFiedlWidget(
      {super.key,
      required this.controller,
      required this.lable,
      required this.error,
      required this.enbale});
  final TextEditingController controller;
  final String lable;
  final String error;
  final bool enbale;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        enabled: enbale,
        controller: controller,
        minLines: 1,
        maxLines: 200,
        decoration: InputDecoration(
          labelText: lable,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return error;
          }
          return null;
        },
      ),
    );
  }
}

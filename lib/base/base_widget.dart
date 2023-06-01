import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import '../share/color.dart';
import 'package:provider/provider.dart';

class PageContainer extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget> action;
  final List<SingleChildWidget> di;

  PageContainer({
    required this.title,
    required this.di,
    required this.child,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...di,
      ],
      child: Scaffold(
          // appBar: AppBar(
          //   actions: action,
          //   centerTitle: true,
          //   title: Text(
          //     title,
          //     style: TextStyle(color: AppColor.blue),
          //   ),
          // ),
          body: child),
    );
  }
}

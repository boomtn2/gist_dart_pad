import 'package:flutter/material.dart';

import '../../../share/widget/search_autocomplete.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchAutoComplete();
    // Card(
    //   color: Colors.blue,
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: TextField(
    //           autofocus: false,
    //           style: TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
    //           decoration: InputDecoration(
    //             filled: true,
    //             fillColor: Colors.white,
    //             hintText: 'Search',
    //             contentPadding:
    //                 const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
    //             focusedBorder: OutlineInputBorder(
    //               borderSide: BorderSide(color: Colors.white),
    //               borderRadius: BorderRadius.circular(5),
    //             ),
    //             enabledBorder: UnderlineInputBorder(
    //               borderSide: BorderSide(color: Colors.white),
    //               borderRadius: BorderRadius.circular(5),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

import 'package:dartpad_code_mobile/event/event_search_gist.dart';
import 'package:dartpad_code_mobile/module/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<String> dataComplete = ["search", "widget", "appbar"];

class SearchAutoComplete extends StatefulWidget {
  const SearchAutoComplete({super.key});

  @override
  State<SearchAutoComplete> createState() => _SearchAutoCompleteState();
}

class _SearchAutoCompleteState extends State<SearchAutoComplete> {
  String _stSearch = "";
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer<HomeBloc>(
          builder: (context, bloc, child) => IconButton(
              onPressed: () {
                bloc.event.add(EventSearchGist(stSearch: _stSearch));
              },
              icon: Icon(Icons.search)),
        ),
        Expanded(
          child: Autocomplete<String>(
            optionsBuilder: (textEditingValue) {
              _stSearch = textEditingValue.text;
              if (textEditingValue.text == "") {
                return const Iterable.empty();
              }
              return dataComplete.where((element) =>
                  element.contains(textEditingValue.text.toLowerCase()));
            },

            // optionsViewBuilder: (context, onSelected, options) {
            //   return _search();
            // },
          ),
        ),
      ],
    );
  }
}

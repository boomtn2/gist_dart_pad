import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../../event/event_delete_gist.dart';
import '../../../share/helper.dart';
import '../../../share/model/gist.dart';
import '../../../share/model/result.dart';
import '../../dartpad/web_view.dart';
import '../../edit/edit.dart';
import '../home_bloc.dart';

class ListGistView extends StatefulWidget {
  const ListGistView({super.key});

  @override
  State<ListGistView> createState() => _ListGistViewState();
}

class _ListGistViewState extends State<ListGistView> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("didChangDependencies");
    var bloc = Provider.of<HomeBloc>(context, listen: false);
    bloc.getGistList();
    bloc.resultStream.listen((event) {
      showResult(event);
    });
  }

  void showResult(Result rs) {
    showSnackBar(
        context: context,
        title: rs.message,
        background: rs.isOK ? Colors.green : Colors.red);
    if (rs.isOK) {
      context.read<HomeBloc>().getGistList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<HomeBloc>(
        builder: (context, homeBloc, child) => StreamProvider<List<Gist>>(
          initialData: [],
          create: (context) => homeBloc.streamListGist,
          //  catchError: (context, error) => error,
          child: Consumer<List<Gist>>(
            builder: (context, value, child) {
              if (value.isEmpty) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.blue,
                ));
              }

              // if (value is RestError) {
              //   return Center(
              //     child: Text(value.message),
              //   );
              // }

              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) => _buildCardGist(value[index]),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCardGist(Gist gist) {
    return Slidable(
      endActionPane: ActionPane(motion: ScrollMotion(), children: [
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditView(gist: gist),
                  ));
            },
            child: Icon(Icons.edit)),
        TextButton(
            onPressed: () {
              context.read<HomeBloc>().event.add(EventDeleteGist(id: gist.id));
            },
            child: Icon(
              Icons.delete,
              color: Colors.red,
            )),
      ]),
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DartPadWebView(gist: gist),
              ));
        },
        child: Card(
          color: Colors.white70,
          elevation: 10,
          child: ListTile(
            title: Text("${gist.description}"),
            subtitle: Text("${gist.id}"),
            trailing: Icon(
              Icons.code,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

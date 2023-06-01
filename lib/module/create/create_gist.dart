import 'package:dartpad_code_mobile/data/remote/gist_service.dart';
import 'package:dartpad_code_mobile/data/repo/gist_repo.dart';
import 'package:dartpad_code_mobile/event/event_create_gist.dart';
import 'package:dartpad_code_mobile/event/event_update_gist.dart';
import 'package:dartpad_code_mobile/module/create/create_bloc.dart';
import 'package:dartpad_code_mobile/share/helper.dart';
import 'package:dartpad_code_mobile/share/model/gist.dart';
import 'package:dartpad_code_mobile/share/model/result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../share/widget/text_field.dart';

class CreateGist extends StatelessWidget {
  const CreateGist({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Gist"),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
        ),
        body: MultiProvider(
          providers: [
            Provider<GistService>(
              create: (context) => GistService(),
            ),
            ProxyProvider<GistService, GistRepo>(
              update: (context, gistService, previous) =>
                  GistRepo(gistService: gistService),
            ),
            ProxyProvider<GistRepo, CreateBloc>(
              update: (context, gistRepo, previous) =>
                  CreateBloc(gistRepo: gistRepo),
            ),
          ],
          child: BodyEdit(),
        ));
  }
}

class BodyEdit extends StatefulWidget {
  const BodyEdit({super.key});

  @override
  State<BodyEdit> createState() => _BodyEditState();
}

class _BodyEditState extends State<BodyEdit> {
  TextEditingController _txtDesController = TextEditingController();
  TextEditingController _txtNameFileController = TextEditingController();
  TextEditingController _txtContentController = TextEditingController();
  final _form = GlobalKey<FormState>();
  late Gist data = Gist(
      id: "123",
      description: "1321654",
      public: false,
      file: FilleGist(content: "20313"));
  bool dataValidate() {
    if (_form.currentState!.validate()) {
      data.description = _txtDesController.text;
      data.file?.content = _txtContentController.text;
      return true;
    }
    return false;
  }

  void showResult(Result rs) {
    showSnackBar(
        context: context,
        title: rs.message,
        background: rs.isOK ? Colors.green : Colors.red);
    if (rs.isOK) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _txtNameFileController.text = "main.dart";
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Provider.of<CreateBloc>(context).resultStream.listen((event) {
      showResult(event);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFiedlWidget(
                  controller: _txtDesController,
                  lable: "Description",
                  error: "Chưa nhập đủ",
                  enbale: true),
              TextFiedlWidget(
                  controller: _txtNameFileController,
                  lable: "NameFile",
                  error: "",
                  enbale: false),
              TextFiedlWidget(
                  controller: _txtContentController,
                  lable: "Code",
                  error: "Nhập vô bạn ơi",
                  enbale: true),
            ],
          ),
        )),
        Consumer<CreateBloc>(
          builder: (context, bloc, child) => Card(
            color: Colors.white60,
            child: Row(
              children: [
                TextButton.icon(
                    onPressed: () {
                      if (dataValidate()) {
                        print("click");
                        bloc.event.add(EventCreateGist(gist: data));
                      }
                    },
                    icon: Icon(Icons.save),
                    label: Text("Save Gist")),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

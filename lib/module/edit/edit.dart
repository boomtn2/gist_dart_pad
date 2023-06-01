import 'package:dartpad_code_mobile/data/remote/gist_service.dart';
import 'package:dartpad_code_mobile/data/repo/gist_repo.dart';
import 'package:dartpad_code_mobile/event/event_delete_gist.dart';
import 'package:dartpad_code_mobile/event/event_update_gist.dart';
import 'package:dartpad_code_mobile/module/edit/edit_bloc.dart';
import 'package:dartpad_code_mobile/share/helper.dart';
import 'package:dartpad_code_mobile/share/model/gist.dart';
import 'package:dartpad_code_mobile/share/model/result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditView extends StatelessWidget {
  const EditView({super.key, required this.gist});
  final Gist gist;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
        ),
        body: MultiProvider(
          providers: [
            Provider<Gist>.value(value: gist),
            Provider<GistService>(
              create: (context) => GistService(),
            ),
            ProxyProvider<GistService, GistRepo>(
              update: (context, gistService, previous) =>
                  GistRepo(gistService: gistService),
            ),
            ProxyProvider<GistRepo, EditBloc>(
              update: (context, gistRepo, previous) =>
                  EditBloc(gistRepo: gistRepo),
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
  TextEditingController _txtIdController = TextEditingController();
  TextEditingController _txtDesController = TextEditingController();
  TextEditingController _txtNameFileController = TextEditingController();
  TextEditingController _txtContentController = TextEditingController();
  final _form = GlobalKey<FormState>();
  late Gist data;
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
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    data = Provider.of<Gist>(context);
    _txtIdController.text = data.id;
    _txtDesController.text = data.description;
    _txtNameFileController.text = data.file!.nameFile;
    _txtContentController.text = data.file!.content!;
    Provider.of<EditBloc>(context).resultStream.listen((event) {
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
              _buildTextField(
                  controller: _txtIdController,
                  lable: "ID",
                  error: "",
                  enbale: false),
              _buildTextField(
                  controller: _txtDesController,
                  lable: "Description",
                  error: "Chưa nhập đủ",
                  enbale: true),
              _buildTextField(
                  controller: _txtNameFileController,
                  lable: "NameFile",
                  error: "",
                  enbale: false),
              _buildTextField(
                  controller: _txtContentController,
                  lable: "Code",
                  error: "Nhập vô bạn ơi",
                  enbale: true),
            ],
          ),
        )),
        Consumer<EditBloc>(
          builder: (context, bloc, child) => Card(
            color: Colors.white60,
            child: Row(
              children: [
                TextButton.icon(
                    onPressed: () {
                      bloc.event
                          .add(EventDeleteGist(id: _txtIdController.text));
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    label: Text("Delete Gist")),
                TextButton.icon(
                    onPressed: () {
                      if (dataValidate()) {
                        bloc.event.add(EventUpdateGist(gist: data));
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

  Widget _buildTextField(
      {required TextEditingController controller,
      required String lable,
      required String error,
      required bool enbale}) {
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

import 'package:dartpad_code_mobile/data/repo/account_repo.dart';
import 'package:dartpad_code_mobile/event/event_save_token_github.dart';
import 'package:dartpad_code_mobile/module/github/github_bloc.dart';
import 'package:dartpad_code_mobile/share/color.dart';
import 'package:dartpad_code_mobile/share/model/account_github.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../share/helper.dart';
import '../../share/model/result.dart';
import '../../share/widget/text_field.dart';

class GitHubView extends StatelessWidget {
  const GitHubView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AccountRepo>(
            create: (context) => AccountRepo(),
          ),
          ProxyProvider<AccountRepo, GithubBloc>(
            update: (context, value, previous) =>
                GithubBloc(accountRepo: value),
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "GitHub",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: BodyGitHub(),
        ));
  }
}

class BodyGitHub extends StatefulWidget {
  const BodyGitHub({super.key});

  @override
  State<BodyGitHub> createState() => _GithubViewState();
}

class _GithubViewState extends State<BodyGitHub> {
  final TextEditingController _txtNameGitHub = TextEditingController();
  final TextEditingController _txtTokenGitHub = TextEditingController();
  final _form = GlobalKey<FormState>();
  AccountGitHub data = AccountGitHub(nameAccount: "", token: "");
  bool dataValidate() {
    if (_form.currentState!.validate()) {
      data.nameAccount = _txtNameGitHub.text;
      data.token = _txtTokenGitHub.text;
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
  void didChangeDependencies() {
    // TODO: implement didChangeDependenciese
    super.didChangeDependencies();
    var bloc = Provider.of<GithubBloc>(context);
    bloc.resultStream.listen((event) {
      showResult(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Consumer<GithubBloc>(
        builder: (context, bloc, child) => Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Consumer<AccountGitHub>(
                            builder: (context, value, child) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Name:${value.nameAccount}"),
                                Text("Token:${value.token}"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextFiedlWidget(
                      controller: _txtNameGitHub,
                      enbale: true,
                      error: "",
                      lable: "Name GitHub"),
                  TextFiedlWidget(
                      controller: _txtTokenGitHub,
                      enbale: true,
                      error: "",
                      lable: "Token"),
                ],
              ),
            ),
            Container(
              color: AppColor.mainColor,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (dataValidate()) {
                          Provider.of<AccountGitHub>(context, listen: false)
                              .nameAccount = data.nameAccount;
                          Provider.of<AccountGitHub>(context, listen: false)
                              .token = data.token;
                          bloc.event.add(EventSaveToken(github: data));
                        }
                      },
                      child: Text("Save")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dartpad_code_mobile/data/repo/account_repo.dart';
import 'package:dartpad_code_mobile/data/repo/gist_repo.dart';
import 'package:dartpad_code_mobile/module/create/create_gist.dart';
import 'package:dartpad_code_mobile/module/home/home.dart';
import 'package:dartpad_code_mobile/module/dartpad/web_view.dart';
import 'package:dartpad_code_mobile/module/splash/splash.dart';
import 'package:dartpad_code_mobile/network/config_github.dart';
import 'package:dartpad_code_mobile/share/model/account_github.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'module/github/github.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AccountRepo gistRepo = AccountRepo();
  ConfigGitHub.accountGitHub = await gistRepo.getAccount();
  runApp(Provider<AccountGitHub>(
      create: (context) => ConfigGitHub.accountGitHub, child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/home",
      routes: {
        "/": (context) => Splash(),
        "/home": (context) => Home(),
        "/create": (context) => CreateGist(),
        "/dartpad": (context) => DartPadWebView(
              gist: null,
            ),
        "/github": (context) => GitHubView()
      },
    );
  }
}

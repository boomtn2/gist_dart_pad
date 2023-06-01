import 'package:dartpad_code_mobile/base/base_widget.dart';
import 'package:dartpad_code_mobile/data/remote/gist_service.dart';
import 'package:dartpad_code_mobile/data/repo/gist_repo.dart';
import 'package:dartpad_code_mobile/module/home/home_bloc.dart';
import 'package:dartpad_code_mobile/share/model/account_github.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widget/body.dart';
import 'widget/search.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainer(
        action: const [],
        di: [
          Provider<GistService>(
            create: (context) => GistService(),
          ),
          ProxyProvider<GistService, GistRepo>(
            update: (context, gistService, previous) =>
                GistRepo(gistService: gistService),
          ),
        ],
        title: "Gist",
        child: SafeArea(
          child: Consumer<GistRepo>(
            builder: (context, gistRepo, child) => Provider<HomeBloc>(
              create: (context) => HomeBloc(gistRepo: gistRepo),
              child: Column(
                children: [
                  ListGistView(),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    color: Color.fromARGB(255, 59, 2, 79),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Card(child: SearchView()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateColor
                                        .resolveWith((states) =>
                                            Color.fromARGB(83, 153, 206, 155))),
                                onPressed: () {
                                  Navigator.pushNamed(context, "/create");
                                },
                                child: Text("New Gist")),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateColor
                                        .resolveWith((states) =>
                                            Color.fromARGB(114, 182, 60, 51))),
                                onPressed: () {
                                  Navigator.pushNamed(context, "/dartpad");
                                },
                                child: Text("Dev Code")),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Color.fromARGB(
                                                131, 179, 131, 206))),
                                onPressed: () {
                                  print("click");
                                  Navigator.pushNamed(context, "/github");
                                },
                                child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Image.asset(
                                      "assets/images/github.png",
                                      fit: BoxFit.fill,
                                    ))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

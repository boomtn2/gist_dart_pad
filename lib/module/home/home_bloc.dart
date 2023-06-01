// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:dartpad_code_mobile/base/base_bloc.dart';
import 'package:dartpad_code_mobile/base/base_event.dart';
import 'package:dartpad_code_mobile/data/repo/gist_repo.dart';
import 'package:dartpad_code_mobile/event/event_delete_gist.dart';
import 'package:dartpad_code_mobile/event/event_search_gist.dart';
import 'package:dartpad_code_mobile/share/model/gist.dart';

class HomeBloc extends BaseBloc {
  final GistRepo _gistRepo;

  StreamController<List<Gist>> _streamListGist = StreamController<List<Gist>>();

  Sink get sinkStreamListGist => _streamListGist.sink;
  Stream<List<Gist>> get streamListGist => _streamListGist.stream;

  List<Gist> dataDefautl = [
    Gist(
        id: "5c0e154dd50af4a9ac856908061291bc",
        description: "Sunflower",
        public: false),
    Gist(
        id: "85e77d36533b16647bf9b6eb8c03296d",
        description: "Animation Discs",
        public: false),
    Gist(
        id: "d57c6c898dabb8c6fb41018588b8cf73",
        description: "Fire Base",
        public: false),
  ];

  List<Gist> dataHolder = [];
  HomeBloc({
    required GistRepo gistRepo,
  }) : _gistRepo = gistRepo;

  @override
  void dispathEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case EventDeleteGist:
        handleEventDelete(event as EventDeleteGist);
        break;
      case EventSearchGist:
        handleEventSearch(event as EventSearchGist);
        break;

      default:
    }
  }

  void getGistList() async {
    try {
      dataHolder = await _gistRepo.getListGist();
      sinkStreamListGist.add(dataHolder);
    } catch (e) {
      sinkStreamListGist.add(dataDefautl);
    }
  }

  void handleEventSearch(EventSearchGist event) async {
    List<Gist> temp = dataHolder
        .where((element) => element.description.contains(event.stSearch))
        .toList();
    sinkStreamListGist.add(temp);
  }

  void handleEventDelete(EventDeleteGist event) async {
    resultSink.add(await _gistRepo.deleteGist(id: event.id));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamListGist.close();
  }
}

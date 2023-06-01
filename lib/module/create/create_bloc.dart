// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartpad_code_mobile/base/base_bloc.dart';
import 'package:dartpad_code_mobile/base/base_event.dart';
import 'package:dartpad_code_mobile/data/repo/gist_repo.dart';
import 'package:dartpad_code_mobile/event/event_create_gist.dart';

class CreateBloc extends BaseBloc {
  GistRepo _gistRepo;
  CreateBloc({
    required GistRepo gistRepo,
  }) : _gistRepo = gistRepo {
    print("new object");
  }

  @override
  void dispathEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case EventCreateGist:
        handleEventCreate(event as EventCreateGist);
        break;
      default:
    }
  }

  handleEventCreate(EventCreateGist event) async {
    var rslt = await _gistRepo.createGist(gist: event.gist);
    resultSink.add(rslt);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("dispose_EditBloc");
    super.dispose();
  }
}

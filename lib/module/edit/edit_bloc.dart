// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartpad_code_mobile/base/base_bloc.dart';
import 'package:dartpad_code_mobile/base/base_event.dart';
import 'package:dartpad_code_mobile/data/repo/gist_repo.dart';
import 'package:dartpad_code_mobile/event/event_delete_gist.dart';
import 'package:dartpad_code_mobile/event/event_update_gist.dart';
import 'package:dartpad_code_mobile/share/model/gist.dart';
import 'package:dartpad_code_mobile/share/model/result.dart';

class EditBloc extends BaseBloc {
  GistRepo _gistRepo;
  EditBloc({
    required GistRepo gistRepo,
  }) : _gistRepo = gistRepo {
    print("new object");
  }

  @override
  void dispathEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case EventDeleteGist:
        handleEventDelete(event as EventDeleteGist);
        break;
      case EventUpdateGist:
        handleEventUpdate(event as EventUpdateGist);
        break;
      default:
    }
  }

  handleEventDelete(EventDeleteGist event) async {
    var rslt = await _gistRepo.deleteGist(id: event.id);
    resultSink.add(rslt);
  }

  handleEventUpdate(EventUpdateGist event) async {
    var rslt = await _gistRepo.updateGist(gist: event.gist);
    resultSink.add(rslt);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("dispose_EditBloc");
    super.dispose();
  }
}

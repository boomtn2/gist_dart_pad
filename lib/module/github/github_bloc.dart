// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartpad_code_mobile/base/base_bloc.dart';
import 'package:dartpad_code_mobile/base/base_event.dart';
import 'package:dartpad_code_mobile/data/repo/account_repo.dart';
import 'package:dartpad_code_mobile/event/event_save_token_github.dart';
import 'package:dartpad_code_mobile/network/config_github.dart';
import 'package:dartpad_code_mobile/share/model/account_github.dart';

class GithubBloc extends BaseBloc {
  AccountRepo _accountRepo;
  GithubBloc({
    required AccountRepo accountRepo,
  }) : _accountRepo = accountRepo;
  @override
  void dispathEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case EventSaveToken:
        handleEventSave(event as EventSaveToken);
        break;
      default:
    }
  }

  void handleEventSave(EventSaveToken event) {
    var rs = _accountRepo.saveAccount(accountGitHub: event.github);
    if (rs.isOK) {
      ConfigGitHub.accountGitHub = event.github;
    }

    resultSink.add(rs);
  }

  void get(EventSaveToken event) async {
    AccountGitHub github = await _accountRepo.getAccount();
    print(github.nameAccount);
    print(github.token);
  }
}

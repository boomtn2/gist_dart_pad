import 'package:dartpad_code_mobile/data/spref/spref.dart';
import 'package:dartpad_code_mobile/share/constant.dart';
import 'package:dartpad_code_mobile/share/model/account_github.dart';
import 'package:dartpad_code_mobile/share/model/result.dart';

class AccountRepo {
  Future<AccountGitHub> getAccount() async {
    String token = await SPref.instance.get(SPrefCache.KEY_TOKEN) ?? "";
    String user = await SPref.instance.get(SPrefCache.KEY_USER) ?? "";
    return AccountGitHub(nameAccount: user, token: token);
  }

  Result saveAccount({required AccountGitHub accountGitHub}) {
    SPref.instance.set(SPrefCache.KEY_TOKEN, accountGitHub.token);
    SPref.instance.set(SPrefCache.KEY_USER, accountGitHub.nameAccount);
    return Result(isOK: true, msg: "");
  }
}

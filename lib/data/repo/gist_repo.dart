import 'package:dartpad_code_mobile/data/remote/gist_service.dart';
import 'package:dartpad_code_mobile/data/repo/respon_status.dart';
import 'package:dartpad_code_mobile/share/model/result.dart';
import 'package:dio/dio.dart';

import '../../share/model/gist.dart';

class GistRepo {
  final GistService _gistService;

  GistRepo({required GistService gistService}) : _gistService = gistService;

  Future<List<Gist>> getListGist() async {
    try {
      var response = await _gistService.getListFileGist(nameGitHub: "boomtn2");
      var listGist = response.data as List;
      var list = listGist.map((e) => Gist.fromMap(e)).toList();
      list.forEach((element) async {
        if (element.file!.content != null) {
          String path = element.file!.content ?? "";
          response = await _gistService.getCode(path: path);
          element.file!.content = response.data;
        }
      });
      return list;
    } on DioError {
    } catch (e) {}

    return Future.error("Không có dữ liệu");
  }

  Future<Result> deleteGist({required String id}) async {
    var result = await _gistService.deleteGist(id: id);
    String stResult = rStatusDeleteGist[result.statusCode] ?? "";
    return Result(isOK: result.statusCode! < 300, msg: stResult);
  }

  Future<Result> updateGist({required Gist gist}) async {
    var result = await _gistService.updateGist(gist: gist);
    String stResult = rStatusUpdateGist[result.statusCode] ?? "";
    return Result(isOK: result.statusCode! < 300, msg: stResult);
  }

  Future<Result> createGist({required Gist gist}) async {
    var result = await _gistService.createGist(gist: gist);
    String stResult = rStatusCreate[result.statusCode] ?? "";
    return Result(isOK: result.statusCode! < 300, msg: stResult);
  }
}

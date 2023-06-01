import 'package:dartpad_code_mobile/network/github_client.dart';
import 'package:dartpad_code_mobile/share/model/gist.dart';
import 'package:dio/dio.dart';

import '../../network/github_content_client.dart';

class GistService {
  Future<Response> getListFileGist({required String nameGitHub}) {
    return GitHubClient.instance.dio.get("users/${nameGitHub}/gists");
  }

  Future<Response> updateGist({required Gist gist}) {
    return GitHubClient.instance.dio
        .patch("gists/${gist.id}", data: gist.toMap());
  }

  Future<Response> deleteGist({required String id}) {
    return GitHubClient.instance.dio.delete("gists/${id}");
  }

  Future<Response> createGist({required Gist gist}) {
    return GitHubClient.instance.dio.post("gists", data: {
      "description": gist.description,
      "public": gist.public,
      "files": {
        "${gist.file!.nameFile}": {"content": gist.file!.content}
      }
    });
  }

  Future<Response> getCode({required String path}) {
    return GitHubContentClient.instance.dio.get(path);
  }
}

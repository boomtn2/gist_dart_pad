import 'package:dio/dio.dart';

import 'config_github.dart';

class GitHubContentClient {
  static final BaseOptions _baseOptions = BaseOptions(
    //baseUrl: "",
    connectTimeout: const Duration(seconds: 5000),
    receiveTimeout: const Duration(seconds: 3000),
  );
  static final Dio _dio = Dio(_baseOptions);
  GitHubContentClient._internal() {
    _dio.interceptors.add(LogInterceptor(responseBody: true));

    // Phiên bản mới của dio phải sử dụng như sau:
    _dio.interceptors.add(InterceptorsWrapper(onRequest:
        (RequestOptions myOption, RequestInterceptorHandler handler) async {
      //  var token = await SPref.instance.get(SPrefCache.KEY_TOKEN);
      // if (token != null) {
      //   myOption.headers["Authorization"] = "Bearer " + token;
      // }
      myOption.headers["Authorization"] =
          "Bearer " + ConfigGitHub.accountGitHub.token;
      return handler.next(myOption);
    }));
  }

  static final GitHubContentClient instance = GitHubContentClient._internal();

  Dio get dio => _dio;
}

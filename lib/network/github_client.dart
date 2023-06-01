import 'package:dartpad_code_mobile/network/config_github.dart';
import 'package:dio/dio.dart';

class GitHubClient {
  static final BaseOptions _baseOptions = BaseOptions(
    baseUrl: "https://api.github.com/",
    connectTimeout: const Duration(seconds: 5000),
    receiveTimeout: const Duration(seconds: 3000),
  );
  static final Dio _dio = Dio(_baseOptions);

  GitHubClient._internal() {
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

  static final GitHubClient instance = GitHubClient._internal();

  Dio get dio => _dio;
}

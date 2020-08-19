
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('Request Log');
    print('URL: ${data.baseUrl}');
    print('Headrs: ${data.headers}');
    print('Body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
      print('Response Log');
      print('Headrs: ${data.headers}');
      print('Status: ${data.statusCode}');
      print('Body: ${data.body}');
      return data;
  }

}
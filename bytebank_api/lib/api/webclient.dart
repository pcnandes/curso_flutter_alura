import 'package:bytebank_persist/api/logging_interceptors.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

final Client client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
  // configuracao de timeout default
  requestTimeout: Duration(seconds: 5)
);

const String baseUrl = 'http://192.168.1.6:8080/transactions';


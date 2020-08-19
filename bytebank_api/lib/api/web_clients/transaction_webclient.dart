import 'dart:convert';
import 'package:bytebank_persist/models/transaction.dart';
import 'package:http/http.dart';
import 'package:bytebank_persist/api/webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    // client foi importado de webclient.dart
    final Response response = await client.get(baseUrl);
      // .timeout(Duration(seconds: 5));

    final List<dynamic> decodedJson = jsonDecode(response.body);
    // exemplo de uso de Map... o map retorna um interable. por isso, é preciso converter para lista (toList)
    return  decodedJson
      .map((dynamic json) => Transaction.fromJson(json))
      .toList();
  }

  Future<Transaction> save (Transaction transaction, String password) async {

    final String trasactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(baseUrl, headers: {
      'Content-type': 'application/json',
      'password': password
    }, body: trasactionJson);

    if(response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    // _throwHttpError(response.statusCode);
    throw HttpException(_getMessage(response.statusCode));
    
  }

  String _getMessage(int statusCode) {
   if(_statusCodeResposnes.containsKey(statusCode)) {
     return _statusCodeResposnes[statusCode]; 
   } else {
     return 'Unknown Error';
   }
   
   
  }

  static final Map<int, String> _statusCodeResposnes = {
    400: 'Ocorreu um erro enviando a transferencia',
    401: 'Ocorreu uma falha na autenticação',
    409: 'Transação já existe'
  };

}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
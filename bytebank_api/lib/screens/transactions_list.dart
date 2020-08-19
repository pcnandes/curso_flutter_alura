import 'package:bytebank_persist/api/web_clients/transaction_webclient.dart';
import 'package:bytebank_persist/components/centered_message.dart';
import 'package:bytebank_persist/components/progress.dart';
import 'package:bytebank_persist/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {

  final TransactionWebClient _webCLient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        // executa a funcao e no retorno da mesma, o builder é chamado
        future: _webCLient.findAll(),
        builder: (context, snapshot) {

          switch(snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              // verifica se tem data, ou seja, nao deu erro.
              if(snapshot.hasData) {
                // snapshot.data tem o resultado do findAll()
                final List<Transaction> transactions = snapshot.data;
                  if(transactions.isNotEmpty) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final Transaction transaction = transactions[index];
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.monetization_on),
                            title: Text(
                              transaction.value.toString(),
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              transaction.contact.accountNumber.toString(),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: transactions.length,
                    );
                  }
                  // se estiver vazio
                  return CenteredMessage('No transactions found', icon: Icons.warning,);
              }
              break;
            return CenteredMessage('Unknown error');
          }
        },
      )
      /*  */
    );
  }
}



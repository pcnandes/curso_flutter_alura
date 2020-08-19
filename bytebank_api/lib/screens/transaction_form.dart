import 'dart:async';

import 'package:bytebank_persist/api/web_clients/transaction_webclient.dart';
import 'package:bytebank_persist/components/progress.dart';
import 'package:bytebank_persist/components/response_dialog.dart';
import 'package:bytebank_persist/components/transaction_auth_dialog.dart';
import 'package:bytebank_persist/models/contact.dart';
import 'package:bytebank_persist/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webCLient = TransactionWebClient();
  // esse id vai identificar a transação. No back ele barra duplicidades caso o usuário clique duas vezes no botão.
  final String transactionId = Uuid().v4();

  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    print('Transaction Form ID: $transactionId');
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Progress(message: 'Sending...',),
                ),
                visible: _sending,
              ),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transfer'), onPressed: () {
                      final double value = double.tryParse(_valueController.text);
                      final transactionCreated = Transaction(
                        transactionId,
                        value,
                        widget.contact,
                      );
                      // repare que estamos passando dois contextos, e precisamos dar nomes diferentes, pois ao salvar precisaremos dar o pop no context
                      showDialog(context: context, builder: (contextDialog) {
                        return TransactionAuthDialog(onConfirm: (String password) {
                          _save(transactionCreated, password, context);
                        }
                        );
                      });
                  },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(Transaction transactionCreated, String password, BuildContext context) async {
    Transaction transaction = await _send(transactionCreated, password, context);
    await _showSuccefullMessage(transaction, context);
  }

  Future _showSuccefullMessage(Transaction transaction, BuildContext context) async {
    if(transaction != null) {
        await showDialog(context: context, builder: (contextDialog) {
          return SuccessDialog('succeful transaction');
        // then é executaod quando o modal é fechado
        });
        Navigator.pop(context);
      }
  }

  Future<Transaction> _send(Transaction transactionCreated, String password, BuildContext context) async {
    setState(() {
      _sending = true;
    });

    // apenas para simular uma demora no acesso ao serviço
    await Future.delayed(Duration(seconds: 2));

    final Transaction transaction = await _webCLient.save(transactionCreated, password)
       .catchError((e) {
         _showErrorMessage(context, message: 'timeout submetting transaction');
         // verifica se e é do tipo Exception. Importante verificar antes de pegar o message
       }, test: (e) => e is TimeoutException)
       .catchError((e) {
         _showErrorMessage(context, message: e.message);
         // verifica se e é do tipo Exception. Importante verificar antes de pegar o message
       }, test: (e) => e is HttpException)
       .catchError((e) {
         _showErrorMessage(context);
         // verifica se e é do tipo Exception. Importante verificar antes de pegar o message
       }, test: (e) => e is HttpException)
       .whenComplete(() {
          setState(() {
            _sending = false;
          });
       });
    return transaction;
  }

  void _showErrorMessage(BuildContext context, {message = 'Erro inesperado!'}) {
    showDialog(context: context, builder: (contextDialog) {
      return FailureDialog(message);
    });
  }
}
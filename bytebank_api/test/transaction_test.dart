
import 'package:bytebank_persist/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('deve retornar o valor quando criamos uma transação', () {
    final Transaction transaction = Transaction(null, 200, null);
    expect(transaction.value, 200);
  });

  test('deve falar quando transferencia for menor que zero', () {
    expect(() => Transaction(null, 0, null), throwsAssertionError);
  });
}
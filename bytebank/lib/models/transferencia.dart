class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(
    this.valor,
    this.numeroConta
  );
  
  @override
  String toString() {
    return 'Transferência $numeroConta $valor';
  }
}
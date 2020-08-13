import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Transferências';


// StatefulWidget -> permite alterar o conteudo apos renderizar
// StatelessWidget -> apos renderizado nao permite atualizar o conteudo
// https://flutter.dev/docs/development/ui/interactive#stateful-and-stateless-widgets

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = List();

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}


class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add), onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FormularioTransferencia();
        })).then((transferenciaRecebida) => atualiza(transferenciaRecebida));
      },),
    );
  }

  void atualiza(Transferencia transferenciaRecebida) {
    if(transferenciaRecebida != null) {
      setState(() {
        widget._transferencias.add(transferenciaRecebida);
      });
    }
  }
}


class ItemTransferencia extends StatelessWidget {
  // final === constante
  final Transferencia _transferencia;

  // construtor
  const ItemTransferencia(this._transferencia);

  @override
  Widget build(Object context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      )
    );
  }
}
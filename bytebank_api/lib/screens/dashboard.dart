import 'package:bytebank_persist/database/dao/contact_dao.dart';
import 'package:bytebank_persist/screens/contacts_list.dart';
import 'package:bytebank_persist/screens/transactions_list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboad'),
        ),
        body: Column(
          // define um alinhamento detro de um column
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('images/bytebank_logo.png'),
            ),
            Container(
              height: 120,
              // adiciona uma rolagem horizontal aos botoes de acao
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  FeatureItem('Transfer', Icons.monetization_on, onClick: () => _showContactList(context)),
                  FeatureItem('Transaction Feed', Icons.description, onClick: () => _showTransactionList(context))
                ],
              ),
            )
          ],
        ), 
      );
  }

  void _showContactList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactList(),
      )
    );
  }

  void _showTransactionList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TransactionsList(),
      )
    );
  }
}


class FeatureItem extends StatelessWidget {

  final String name;
  final IconData icon;
  final Function onClick;


  // @required -> indica que esse método precisa ser implementado por quem for usa-lo
  // assert -> adiciona uma validacao
  const FeatureItem(this.name, this.icon, {@required this.onClick}): assert(icon != null), assert(onClick != null);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      // GestureDetector permite criar eventos.. como click
      // InkWell mesmo q o GestureDetector, mas com efeitos do material. Pra funcionar corretamente,
      //  é precido coloca-lo dentro do material e definir a cor
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            // height: 100,
            width: 150,
            padding: const EdgeInsets.all(8.0),
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        icon,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      Text(name, style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
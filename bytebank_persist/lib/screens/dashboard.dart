import 'package:bytebank_persist/screens/contacts_list.dart';
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              // GestureDetector permite criar eventos.. como click
              // InkWell mesmo q o GestureDetector, mas com efeitos do material. Pra funcionar corretamente,
              //  é precido coloca-lo dentro do material e definir a cor
              child: Material(
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ContactList(),
                      )
                    );
                  },
                  child: Container(
                    height: 100,
                    width: 150,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.people,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        Text('Contacts', style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),)
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
  }
}

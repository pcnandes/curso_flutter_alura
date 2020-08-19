import 'package:bytebank_persist/database/dao/contact_dao.dart';
import 'package:bytebank_persist/screens/dashboard.dart';
import 'package:bytebank_persist/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(contactDao: ContactDao(),));
  
  // save(Transaction(200.0, Contact(0, 'Paulo', 1111))).then((t) => print(t));
  // findAll().then((transactions) => print('new Transactions $transactions'));
  
  /* criando um contato de exemplo
  save(Contact(0, 'alex', 1000)).then((id) {
    findAll().then((contacts) => debugPrint(contacts.toString()));
  });*/
}

class MyApp extends StatelessWidget {

  final ContactDao contactDao;

  const MyApp({ @required this.contactDao });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      // aqui passamos a instancia que será repassada como dependencia 
      contactDao: contactDao,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          )
        ),
        home: Dashboard(),
      ),
    );
  }
}


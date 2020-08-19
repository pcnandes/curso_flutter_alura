import 'package:bytebank_persist/database/dao/contact_dao.dart';
import 'package:bytebank_persist/models/contact.dart';
import 'package:bytebank_persist/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // recupero as dependencias 
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('New Contact'),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name'
              ),
              style: TextStyle(fontSize: 24.0),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _accountController,
                decoration: InputDecoration(
                  labelText: 'Account Number'
                ),
                style: TextStyle(fontSize: 24.0),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: (){
                    final String name = _nameController.text;
                    final int accountNumber = int.tryParse(_accountController.text);
                    final Contact newContact = Contact(0, name, accountNumber);
                    // passo o contactDao que foi pego como dependencia
                    _save(dependencies.contactDao, newContact, context);
                  },
                  child: Text('Create'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _save(ContactDao contactDao, Contact newContact, BuildContext context) async {
    await contactDao.save(newContact);
    Navigator.pop(context);
  }
}
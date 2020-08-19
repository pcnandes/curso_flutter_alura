import 'package:bytebank_persist/components/progress.dart';
import 'package:bytebank_persist/database/dao/contact_dao.dart';
import 'package:bytebank_persist/models/contact.dart';
import 'package:bytebank_persist/screens/contact_form.dart';
import 'package:bytebank_persist/screens/transaction_form.dart';
import 'package:bytebank_persist/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  
  @override
  Widget build(BuildContext context) {
    // recupero as dependencias
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Transfer')),
      // FOrma dinamica de aualizar uma lista. Na pratica, essa lista é do tipo statefullwidget
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        // primeiro ele executada o future, quando ocorrer uma resposta ele executa o builder (nosso callback)
        // delay criado so para testar as ações possíveis
        future: Future.delayed(Duration(seconds: 1)).then((value) => dependencies.contactDao.findAll()),
        // https://api.flutter.dev/flutter/widgets/AsyncSnapshot-class.html        
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            // ainda nao foi executado, ou seja, ainda nel foi clicado
            case ConnectionState.none:
              break;
            // indica que ainda está carregando
            case ConnectionState.waiting:
              return Progress();
              break;
            // indica que tem um dado disponível mas ainda nao terminou, usado para downloads por ex. onde pode carregar partes STREAM
            case ConnectionState.active:
              break;
            // terminoi o processo
            case ConnectionState.done:
              if(snapshot.data != null) {
                // snapshot.data -> contem os dados resultantes do metodo passado no future
                final List<Contact> contacts = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Contact contact = contacts[index];
                    return _ContactItem(contact, onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TransactionForm(contact)), );
                    },);
                  },
                  // gera o index que será passado para o builder
                  itemCount: contacts.length,
                );
              }
              break;
          }
          // isso nao deve ocorrer, mas entra como usa segudrança
          return Text('Uknown error');
        }
      ),
      /* Forma estática de apresentar uma lista
      ListView.builder(
        itemBuilder: (context, index) {
          final Contact contact = contacts[index];
          return _ContactItem(contact);
        },
        // gera o index que será passado para o builder
        itemCount: contacts.length,
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContactForm()
            )
          ).then((value) {
            setState(() {
              widget.createState();
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  
  final Contact contact;
  final Function onClick;


  //construtor
  _ContactItem(this.contact, {this.onClick});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(
          contact.name, 
          style: TextStyle(
            fontSize: 24.0
          ),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(
            fontSize: 16.0
          ),
        ),
      ),
    );
  }
}

import 'package:bytebank_persist/models/contact.dart';
import 'package:bytebank_persist/database/app_database.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {

  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';
  static const tableSql = 'CREATE TABLE $_tableName('
    '$_id INTEGER PRIMARY KEY, '
    '$_name TEXT, '
    '$_accountNumber INTEGER)';

  Future<int> save(Contact contact) async {
    // precisei fazei o import manual para o getDatabase() do app_database.dart
    final Database db = await getDatabase();
    // é preciso criar um map para inserir no sqllite
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert(_tableName, contactMap);
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = Map();
    // nao informando fica autoincrement
    // contactMap['id'] = contact.id;
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return contactMap;
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String,dynamic>> resultado = await db.query(_tableName);
    
    List<Contact> contacts = _toList(resultado);

    return contacts;
  }

  List<Contact> _toList(List<Map<String, dynamic>> resultado) {
    final List<Contact> contacts = List();
    for(Map<String, dynamic> row in resultado) {
      final Contact contact = Contact(
        row[_id],
        row[_name],
        row[_accountNumber],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}
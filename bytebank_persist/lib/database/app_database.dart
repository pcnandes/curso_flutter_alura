import 'package:bytebank_persist/database/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// cria o banco de dados
Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(path, onCreate: (db, version) {
      // executa uma strução sql. Tem q ser compatível com SQL lite
      db.execute(ContactDao.tableSql);
    }
    , version: 1,
    // quando voltar uma versao do banco de dados a base é limpa
    // onDowngrade: onDatabaseDowngradeDelete,
  );
}




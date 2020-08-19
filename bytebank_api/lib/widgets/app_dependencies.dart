
import 'package:bytebank_persist/database/dao/contact_dao.dart';
import 'package:flutter/material.dart';

// contem as dependencias do dart. FUnciona como um injetor de dependencias
// permite propagar os dados para tds os filhos
class AppDependencies extends InheritedWidget {

  final ContactDao contactDao;

  AppDependencies({ 
    @required this.contactDao,
    @required Widget child,
  }) : super(child: child);


  static AppDependencies of(BuildContext context) => 
    context.dependOnInheritedWidgetOfExactType<AppDependencies>();

  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    throw contactDao != oldWidget.contactDao;
  }
  
}
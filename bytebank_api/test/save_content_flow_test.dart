import 'package:bytebank_persist/main.dart';
import 'package:bytebank_persist/models/contact.dart';
import 'package:bytebank_persist/screens/contact_form.dart';
import 'package:bytebank_persist/screens/contacts_list.dart';
import 'package:bytebank_persist/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'matchers.dart';
import 'mocks.dart';

void main() {
  testWidgets('Deve validar o fluxo do salvar', (tester) async {
    final mockContactDao = MockContactDao();

    // passando o _dao mockado por para suprir as depedencias
    await tester.pumpWidget(MyApp(contactDao: mockContactDao,));
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final transferFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);

    // simulando o click
    await tester.tap(transferFeatureItem);

    // realiza as tarefas necessárias para a troca de pagina
    // precisa ser executado em td mudança de tela
    await tester.pumpAndSettle();

    // agroa que clicou precisamos encontrar a lista de contatos
    final contactsList = find.byType(ContactList);
    expect(contactsList, findsOneWidget);

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);

    // verifica se determinada funcao foi chamada uma vez
    verify(mockContactDao.findAll()).called(1);


    // faz outro clique e vefirica se renderizou o formulário
    await tester.tap(fabNewContact);

    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    // verifica se carregou o formulário pegando um text field
    final nameTextField = find.byWidgetPredicate((widget)  => _textFieldMatcher(widget, 'Full Name'));

    expect(nameTextField, findsOneWidget);

    // preencho o formulário
    await tester.enterText(nameTextField, "Alex");

    // verifica se carregou o formulário pegando um text field
    final accountNumeberTextField = find.byWidgetPredicate((widget)  => _textFieldMatcher(widget, 'Account Number'));

    expect(accountNumeberTextField, findsOneWidget);

    // preencho o formulário
    await tester.enterText(accountNumeberTextField, '1000');

    // recupera o botão
    final createButton = find.widgetWithText(RaisedButton, 'Create');
    // verifica se o botão existe
    expect(createButton, findsOneWidget);
    // clica no botao
    await tester.tap(createButton);

    // verifica se determinada funcao foi chamada uma vez
    // para que funcione é preciso definir o equal e o hashcode do objeto Contact
    verify(mockContactDao.save(Contact(0, 'Alex', 1000))).called(1);

    await tester.pumpAndSettle();

    // verifica se voltou 
    final contactsListBack = find.byType(ContactList);
    expect(contactsListBack, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);

  });
}

bool _textFieldMatcher(Widget widget, String labelText) {
  if (widget is TextField) {
    return widget.decoration.labelText == labelText;
  }
  return false;
}
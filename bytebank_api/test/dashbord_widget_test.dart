import 'package:bytebank_persist/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Deve apresentar imagem principal quando o dashboard for carregado', (WidgetTester tester) async {
    // executa um widget
    await tester.pumpWidget(
      // nosso widget depende de um outro, que no caso depende do MyApp. Porém na pratica ele depende mesmo é do MaterialApp
      MaterialApp(home: Dashboard())
    );
    // busca por uma imagem
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });


  testWidgets('Deve encontrar a funcionalidade de Transferenca quando o dashboard for carregado', (WidgetTester tester) async {
    // executa um widget
    await tester.pumpWidget(
      // nosso widget depende de um outro, que no caso depende do MyApp. Porém na pratica ele depende mesmo é do MaterialApp
      MaterialApp(home: Dashboard())
    );
    // busca por uma imagem
    
    // Outros finders
    // https://api.flutter.dev/flutter/flutter_test/CommonFinders-class.html
    final iconeTransferFearureItem = find.widgetWithIcon(FeatureItem, Icons.monetization_on);
    expect(iconeTransferFearureItem, findsOneWidget);
  });
}
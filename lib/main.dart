import 'package:contact_app/pages/contact_details.dart';
import 'package:contact_app/pages/contact_list_page.dart';
import 'package:contact_app/pages/launcher_page.dart';
import 'package:contact_app/pages/login_page.dart';
import 'package:contact_app/pages/new_contact_page.dart';
import 'package:contact_app/provider/contactProvider.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>ContactProvider()..getAllContacts()),
      // ChangeNotifierProvider(create: (context)=>ContactProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LauncherPage.routeName,
      routes: {
        ContactListPage.routeName: (context) => ContactListPage(),
        NewContactPage.routeName: (context) => NewContactPage(),
        ContactDetails.routeName: (context) => ContactDetails(),
        LauncherPage.routeName: (context) => LauncherPage(),
        LoginPage.routeName: (context) => LoginPage(),
      },
    );
  }
}

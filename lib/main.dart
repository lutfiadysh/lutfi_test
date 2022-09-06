import 'package:flutter/material.dart';
import 'package:lutfi_ardiansyah_test/injection/injection_container.dart' as gi;
import 'package:lutfi_ardiansyah_test/persentation/pages/main_page.dart';

void main() {
  gi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lutfi Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

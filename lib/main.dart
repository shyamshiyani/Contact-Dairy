import 'package:contact_dairy/provider/add_provider.dart';
import 'package:contact_dairy/provider/hide_provider.dart';
import 'package:contact_dairy/screen/detail.dart';
import 'package:contact_dairy/screen/hide_contact.dart';
import 'package:contact_dairy/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const Myapp(),
  );
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HideContactProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.system,
        routes: {
          '/': (context) => const Home_Page(),
          'Details': (context) => const Details(),
          'Hide': (context) => const Hide(),
        },
      ),
    );
  }
}

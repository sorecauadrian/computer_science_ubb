import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/dream_provider.dart';
import 'screens/dream_list_screen.dart';
import 'screens/dream_add_screen.dart';
import 'screens/dream_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DreamProvider()),
      ],
      child: MaterialApp(
        title: 'Dream Journal',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => DreamListScreen(),
          '/add': (context) => DreamAddScreen(),
          '/details': (context) => DreamDetailsScreen(),
        },
      ),
    );
  }
}

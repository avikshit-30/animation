import 'package:animation/view/cartscreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:animation/models/model.dart';
import 'package:animation/viewmodel/viewModel.dart';
import 'package:animation/view/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ItemsViewModel()),
      ],
      child: MaterialApp(
        title: 'My App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => MyHomePage(),
          '/screen2': (context) => ItemsScreen(),
          '/screen3': (context) => CartScreen(),
        },
      ),
    );
  }
}

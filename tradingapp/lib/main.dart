import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tradingapp/screens/login_screen.dart';
import 'package:tradingapp/screens/market_data_screen.dart';
import 'package:tradingapp/screens/order_screen.dart';
import 'package:tradingapp/screens/trading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // This should be the first line in main
  await Firebase.initializeApp();
  DartPluginRegistrant.ensureInitialized();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trading App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/market': (context) => MarketDataScreen(),
        '/trading': (context) => TradingScreen(),
        '/orders': (context) => OrderScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}

import 'package:campon_app/loading/loading_screen.dart';
import 'package:campon_app/store/cart.dart';
import 'package:campon_app/store/payment.dart';
import 'package:campon_app/store/storemain.dart';
import 'package:campon_app/user/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'example/Utils/dark_lightmode.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ColorNotifire()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CampOn',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoadingScreen(),
      // home: Payment(),
      // home: StoreMain(),
      // home: Login(),
    );
  }
}

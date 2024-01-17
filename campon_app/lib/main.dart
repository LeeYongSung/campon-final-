import 'package:campon_app/camp/camp_main_screen.dart';
import 'package:campon_app/example/IntroScreen/onbording.dart';
import 'package:campon_app/loading/loading_screen.dart';
import 'package:campon_app/camp/campproduct.dart';
import 'package:campon_app/camp/campdetail.dart';
import 'package:campon_app/example/IntroScreen/onbording.dart';
import 'package:campon_app/store/productdetail.dart';
import 'package:campon_app/store/storemain.dart';
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
      home: const LoadingScreen(),
    );
  }
}

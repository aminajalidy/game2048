import 'package:flutter/material.dart';
import 'package:game2048/base/engine/game_engine.dart';
import 'package:localstorage/localstorage.dart';
import 'base/interface/gamescreen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  localStorage.setItem('bestScore', '0');
  runApp(
    ChangeNotifierProvider(
      create: (context) => GameEngine(size: 4),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2048',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(), 
    );
  }
}
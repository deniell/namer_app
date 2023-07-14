import 'package:flutter/material.dart';
import 'package:namer_app/core/app_state.dart';
import 'package:namer_app/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(NamerApp());
}

class NamerApp extends StatelessWidget {
  const NamerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: HomePage(),
      ),
    );
  }
}

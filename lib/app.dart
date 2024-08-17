import 'package:flutter/material.dart';
import 'package:paty_cosmeticos/config/router.dart';
import 'package:paty_cosmeticos/config/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme().getTheme(),
      routerConfig: router,
    );
  }
}
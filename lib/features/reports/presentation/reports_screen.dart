import 'package:flutter/material.dart';
import 'package:paty_cosmeticos/shared/widgets/bottom_navigation.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen'),
      ),
      body: const Center(
        child: Text('Bienvenido a la pantalla de reportes'),
      ),
    );
  }
}
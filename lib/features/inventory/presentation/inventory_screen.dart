import 'package:flutter/material.dart';
import 'package:paty_cosmeticos/shared/widgets/bottom_navigation.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen'),
      ),
      body: const Center(
        child: Text('Bienvenido a la pantalla de inventario'),
      ),
    );
  }
}
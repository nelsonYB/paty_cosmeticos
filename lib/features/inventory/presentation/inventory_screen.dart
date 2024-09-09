import 'package:flutter/material.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';
  String _selectedCategory = 'Todas';
  List<String> _categories = ['Todas', 'Shampoo', 'Acondicionador', 'Mascarilla', 'Tinte', 'Otros'];
  

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
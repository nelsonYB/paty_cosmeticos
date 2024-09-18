import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paty_cosmeticos/features/inventory/domain/entities/product.dart';
import 'package:paty_cosmeticos/features/inventory/presentation/widgets/movements_tab.dart';
import 'package:paty_cosmeticos/features/inventory/presentation/widgets/products_tab.dart';
import 'package:paty_cosmeticos/features/inventory/presentation/widgets/suppliers_tab.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/inventory_repository_impl.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Productos'),
            Tab(text: 'Proveedores'),
            Tab(text: 'Movimientos'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ProductsTab(),
          SuppliersTab(),
          MovementsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.push('/inventory/add-product');
        },
      ),
    );
  }


}



import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paty_cosmeticos/config/app_scaffold.dart';
import 'package:paty_cosmeticos/features/auth/presentation/register_screen.dart';
import 'package:paty_cosmeticos/features/clients/presentation/clients_screen.dart';
import 'package:paty_cosmeticos/features/home/presentation/home_screen.dart';
import 'package:paty_cosmeticos/features/inventory/presentation/screens/inventory_screen.dart';
import 'package:paty_cosmeticos/features/inventory/presentation/widgets/forms/product_edit_form_screen.dart';
import 'package:paty_cosmeticos/features/inventory/presentation/widgets/forms/product_form_screen.dart';
import 'package:paty_cosmeticos/features/reports/presentation/reports_screen.dart';
import 'package:paty_cosmeticos/features/settings/presentation/settings_screen.dart';

import '../features/auth/presentation/login_screen.dart';


final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const AppScaffold(selectedIndex: 0, child: HomeScreen()),
    ),
    GoRoute(
      path: '/inventory',
      builder: (context, state) => const AppScaffold( selectedIndex: 1,child: InventoryScreen()),
      routes: [
        GoRoute(
          path: 'add-product',
          builder: (context, state) => const ProductFormScreen(),
        ),
        GoRoute(
          path: 'edit-product/:id',
          builder: (context, state) {
            final productId = int.tryParse(state.pathParameters['id'] ?? '');
            if(productId == null) {
              return const Scaffold(
                body: Center(
                  child: Text('Producto no encontrado'),
                ),
              );
            }
            return ProductEditFormScreen(productId: productId);
          }
        ),
      ]
    ),
    GoRoute(
      path: '/clients',
      builder: (context, state) => const AppScaffold(selectedIndex: 2, child: ClientsScreen()),
    ),
    GoRoute(
      path: '/reports',
      builder: (context, state) => const AppScaffold(selectedIndex: 3, child: ReportsScreen()),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const AppScaffold(selectedIndex: 4, child: SettingsScreen()
    ),
    ),
  ]
);
import 'package:go_router/go_router.dart';
import 'package:paty_cosmeticos/config/app_scaffold.dart';
import 'package:paty_cosmeticos/features/auth/presentation/register_screen.dart';
import 'package:paty_cosmeticos/features/clients/presentation/clients_screen.dart';
import 'package:paty_cosmeticos/features/home/presentation/home_screen.dart';
import 'package:paty_cosmeticos/features/inventory/presentation/screens/inventory_screen.dart';
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
      builder: (context, state) => AppScaffold(selectedIndex: 0, child: const HomeScreen()),
    ),
    GoRoute(
      path: '/inventory',
      builder: (context, state) => AppScaffold( selectedIndex: 1,child: const InventoryScreen()),
      routes: [
        GoRoute(
          path: 'add-product',
          builder: (context, state) => const ProductFormScreen(),
        ),
      ]
    ),
    GoRoute(
      path: '/clients',
      builder: (context, state) => AppScaffold(selectedIndex: 2, child: const ClientsScreen()),
    ),
    GoRoute(
      path: '/reports',
      builder: (context, state) => AppScaffold(selectedIndex: 3, child: const ReportsScreen()),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => AppScaffold(selectedIndex: 4, child: const SettingsScreen()
    ),
    ),
  ]
);
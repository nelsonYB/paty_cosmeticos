import 'package:go_router/go_router.dart';
import 'package:paty_cosmeticos/config/app_scaffold.dart';
import 'package:paty_cosmeticos/features/clients/presentation/clients_screen.dart';
import 'package:paty_cosmeticos/features/home/presentation/home_screen.dart';
import 'package:paty_cosmeticos/features/inventory/presentation/inventory_screen.dart';
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
      path: '/home',
      builder: (context, state) => AppScaffold(child: HomeScreen(), selectedIndex: 0),
    ),
    GoRoute(
      path: '/inventory',
      builder: (context, state) => AppScaffold(child: InventoryScreen(), selectedIndex: 1),
    ),
    GoRoute(
      path: '/clients',
      builder: (context, state) => AppScaffold(child: ClientsScreen(), selectedIndex: 2),
    ),
    GoRoute(
      path: '/reports',
      builder: (context, state) => AppScaffold(child: ReportsScreen(), selectedIndex: 3),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => AppScaffold(child: SettingsScreen(), selectedIndex: 4)
    ),
  ]
);
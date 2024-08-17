import 'package:go_router/go_router.dart';
import 'package:paty_cosmeticos/features/home/presentation/home_screen.dart';

//import '../features/auth/presentation/login_screen.dart';


final GoRouter router = GoRouter(
  routes: [
    /*GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),*/
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
  ]
);
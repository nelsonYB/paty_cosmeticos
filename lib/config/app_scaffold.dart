import 'package:flutter/material.dart';
import 'package:paty_cosmeticos/shared/widgets/bottom_navigation.dart';

class AppScaffold extends StatelessWidget {
  
  final Widget child;
  final int selectedIndex;

  AppScaffold({
    required this.child,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigation(
        selectedIndex: selectedIndex,
      ),
    );
  }
}